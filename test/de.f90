program integrate
  ! calculate normal stress beneath a circular load.
  ! the stress function is oscillatory at the surface (z=0)
  ! but can be addressed using double exponential integration.
  ! https://www.kurims.kyoto-u.ac.jp/~prims/pdf/41-4/41-4-36.pdf

  use modintde, only: intdeo
  use iso_fortran_env, only: dp=>real64
  implicit none
  real(dp), parameter :: epsrel = sqrt(epsilon(1.0_dp))
  real(dp), parameter :: pi = 3.141592653589793238460d0
  real(dp) :: pressure, force, radius, z
  real(dp) i, err
  integer nn

  pressure = 0.69_dp                 ! Load pressure, MPa
  force = 20000.0_dp                 ! Load force, N
  radius = sqrt(force/(pressure*pi)) ! Load radius, mm
  ! evaluation depth, mm
  z = 0.0_dp

  nn = 0
  call intdeo(f, 0.0d0, radius, epsrel, i, err)
  write (*, *) 'normal stress, MPa =', -pressure*radius*i, ',  err=', err, ',  n=', nn

  contains

    function f(x)
      real(dp), intent(in) :: x
      real(dp) :: f
      f = (1.0_dp+(x*z))*bessel_j1(radius*x)*exp(-x*z)
      nn = nn + 1
    end function f

end program
