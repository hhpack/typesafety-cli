<?hh //strict

namespace typesafetycli;

interface Client<TRequest, TResponse>
{
    public function send(TRequest $request) : TResponse;
}
