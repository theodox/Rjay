import UnityEngine


struct ExhaustSystem:
    public _Emitter as ParticleSystem
    public _Rate as int
    public _Threshold as single
    public _Power as int


class Exhaust(MonoBehaviour):

    public _Thruster as Thruster
    public _Emitters as (ExhaustSystem)

    def Update():
        v = _Thruster._Governor._Value
        for sys in _Emitters:
            vr = Mathf.Pow(v - sys._Threshold, sys._Power + 1 )

            sys._Emitter.emissionRate = Lerp(0, sys._Rate, vr )
