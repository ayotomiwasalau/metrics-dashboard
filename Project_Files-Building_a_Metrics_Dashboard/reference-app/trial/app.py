from flask import Flask, render_template, request, jsonify
import logging
from jaeger_client import Config
import requests
# from opentelemetry import trace
# from opentelemetry.exporter import jaeger
# from opentelemetry.sdk.trace.export import BatchExportSpanProcessor
from opentelemetry.instrumentation.flask import FlaskInstrumentor
from opentelemetry.instrumentation.requests import RequestsInstrumentor
# from opentelemetry.sdk.trace import TracerProvider
# from opentelemetry.sdk.trace.export import (
#     ConsoleSpanExporter,
#     SimpleExportSpanProcessor,
# )

# trace.set_tracer_provider(TracerProvider())
# trace.get_tracer_provider().add_span_processor(
#     SimpleExportSpanProcessor(ConsoleSpanExporter())
# )

app = Flask(__name__)
FlaskInstrumentor().instrument_app(app)
RequestsInstrumentor().instrument()


def init_tracer(service):
    logging.getLogger('').handlers = []
    logging.basicConfig(format='%(message)s', level=logging.DEBUG)

    config = Config(
        config={
            'sampler': {
                'type': 'const',
                'param': 1,
            },
            'logging': True,
        },
        service_name=service,
    )

    # this call also sets opentracing.tracer
    return config.initialize_tracer()

tracer = init_tracer('trial')


@app.route('/')
def homepage():
    with tracer.start_span('get-python-jobs') as span:
        homepages = []
        res = requests.get('https://jobs.github.com/positions.json?description=python')
        span.set_tag('first-tag', len(res.json()))
        for result in res.json():
            try:
                homepages.append(requests.get(result['company_url']))
            except:
                return "Unable to get site for %s" % result['company']



    return jsonify(homepages)