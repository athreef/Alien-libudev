use Alien::Base::ModuleBuild;
use Devel::AssertOS qw[Linux];
use Config;

use Alien::autoconf;
use Alien::automake;
use Alien::libtool;
use Env qw( @PATH );

unshift @ENV, Alien::automake->bin_dir, Alien::autoconf->bin_dir, Alien::libtool->bin_dir;

my $build = Alien::Base::ModuleBuild->new(
    module_name => 'Alien::libudev',
    license => 'perl',
    alien_bin_requires => {
    },
    configure_requires => {
        'Alien::Autotools' => '0.000_006',
        'Alien::Base::ModuleBuild' => 0,
        'Module::Build' => 0,
    },
    build_requires => {
        # TODO: fallback to HTTP download when IO::Socket::SSL doesn't exist
        'IO::Socket::SSL' => 0,
    },
    recommends => {
        'IO::Socket::SSL' => 0
    },
    test_requires => {
        'Test::More'         => 0,
        'ExtUtils::CBuilder' => 0,
        'Test::Alien'        => '0.05',
        'Test2'              => '1.302015',
        'Test2::Suite'       => '0.000030',
    },
    requires => {
        'perl' => '5.008001',
        'Alien::Base' => '0.030',
    },
    dist_author => 'Ahmad Fatoum <athreef@cpan.org>',
    alien_name => 'libudev',
    alien_repository => {
        protocol => 'http',
        host     => 'github.com',
        location => '/gentoo/eudev/archive',
        exact_filename => 'master.tar.gz',
    },
    alien_inline_auto_include => [ 'libudev.h' ],
    alien_stage_install => 1,

    alien_build_commands => [
        'autoreconf -i',
        '%c --prefix=%s',
        'make -C src/shared',
        'make -C src/libudev',
    ],
    alien_install_commands => ['make -C src/libudev install'],
    # extra_compiler_flags => Alien::CMake->config('cflags'),
    # extra_linker_flags   => Alien::CMake->config('libs'),
);

$build->create_build_script;
#$build->dispatch('distmeta');
#$build->dispatch('manifest');
#$build->dispatch('build');
