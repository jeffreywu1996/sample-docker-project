from fastapi import FastAPI
from apis import demo, healthcheck

app = FastAPI()


@app.on_event("startup")
async def init_conns():
    """Init external connections & middlewares
    All clients will be initialized once only as Singletons
    """


app.include_router(
    demo.router,
    # prefix="/demo",
    tags=["Thing"],
    responses={404: {
        "message": "Not found"
    }},
)

app.include_router(
    healthcheck.router,
    # prefix="/healthcheck",
    tags=["Thing"],
    responses={404: {
        "message": "Not found"
    }},
)
