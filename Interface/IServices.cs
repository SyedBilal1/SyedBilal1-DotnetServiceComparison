namespace API.Interface;
public interface ISingleton
{
    Guid Value();
}
public interface IScoped
{
    Guid Value();

}
public interface ITransient
{
    Guid Value();

}