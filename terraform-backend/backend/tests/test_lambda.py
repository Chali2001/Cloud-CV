def handler(event, context):
    return {
        "statusCode": 200,
        "body": {
            "count": 1
        }
    }
from lambda_function import handler

def test_lambda_returns_200_and_count():
    event = {}
    context = None

    response = handler(event, context)

    assert response["statusCode"] == 200
    assert "count" in response["body"]