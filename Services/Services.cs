using API.Interface;

namespace API.Services;

public class Services : ISingleton, IScoped, ITransient
{
    private Guid _guid = Guid.NewGuid();
    public Guid Value() => _guid;

}