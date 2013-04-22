/**
 * User: revisual.co.uk
 * Date: 16/04/13
 * Time: 22:04
 */
package ash.fsm
{
public class DynamicComponentProvider  implements IComponentProvider
{
    private var _closure:Function;

    public function DynamicComponentProvider( closure:Function)
    {
        _closure = closure;
    }

    public function getComponent():*
    {
        return _closure();
    }

    public function get identifier():*
    {
        return _closure;
    }
}
}