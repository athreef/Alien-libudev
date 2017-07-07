use Test::More;
use Test::Alien 0.05;
use Alien::libudev;

alien_ok 'Alien::libudev';
my $xs = do { local $/; <DATA> };
xs_ok $xs, with_subtest {
    my($module) = @_;
    is $module->xs_new_ref_then_unref, 1, "Testing udev_{new, ref, unref}";
};

done_testing;

__DATA__

#include "EXTERN.h"
#include "perl.h"
#include "XSUB.h"
#include <libudev.h>
#include <stddef.h>

int xs_new_ref_then_unref(const char *s) {
    struct udev *tree = udev_new();
    (void)s;

    tree = udev_ref(tree);
    udev_unref(tree); tree = udev_unref(tree);
    return tree == NULL;
}
MODULE = TA_MODULE PACKAGE = TA_MODULE

int xs_new_then_unref(class);
 const char *class;
