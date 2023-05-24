#include <erl_nif.h>

static ERL_NIF_TERM
avg(ErlNifEnv* env, int argc, const ERL_NIF_TERM argv[])
{
    return enif_make_int(env, 2);
}

static ERL_NIF_TERM
max(ErlNifEnv* env, int argc, const ERL_NIF_TERM argv[])
{
    return enif_make_int(env, 3);
}

static ERL_NIF_TERM
min(ErlNifEnv* env, int argc, const ERL_NIF_TERM argv[])
{
    return enif_make_int(env, 1);
}

static ErlNifFunc nif_funcs[] =
{
    {"avg", 1, avg},
    {"max", 1, max},
    {"min", 1, min}
};

ERL_NIF_INIT(Elixir.Processor,nif_funcs,NULL,NULL,NULL,NULL)