# Copyright 1999-2021 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI="8"
ETYPE="sources"
K_WANT_GENPATCHES="base extras experimental"
K_GENPATCHES_VER="22"
K_SECURITY_UNSUPPORTED="1"
K_NOSETEXTRAVERSION="1"
XANMOD_VERSION="1"
XANMOD_URI="https://github.com/xanmod/linux/releases/download/"

HOMEPAGE="https://xanmod.org"
LICENSE+=" CDDL"
KEYWORDS="~amd64"
IUSE="experimental"

inherit kernel-2
detect_version

DESCRIPTION="XanMod kernel sources, including the Gentoo patchset"
SRC_URI="
	${KERNEL_BASE_URI}/linux-${KV_MAJOR}.${KV_MINOR}.tar.xz
	${XANMOD_URI}/${OKV}-xanmod${XANMOD_VERSION}/patch-${OKV}-xanmod${XANMOD_VERSION}.xz
	${GENPATCHES_URI}
"

UNIPATCH_LIST="${DISTDIR}/patch-${OKV}-xanmod${XANMOD_VERSION}.xz"

# excluding all minor kernel revision patches; XanMod will take care of that
UNIPATCH_EXCLUDE="${UNIPATCH_EXCLUDE} 1*_linux-${KV_MAJOR}.${KV_MINOR}.*.patch"

# excluding GCC CPU optimizations patch, since it's included in XanMod too
UNIPATCH_EXCLUDE="${UNIPATCH_EXCLUDE} 5*_*cpu-optimization*.patch"

# excluding BMQ/PDS schedulers, since those don't play well with XanMod
UNIPATCH_EXCLUDE="${UNIPATCH_EXCLUDE} 502*_BMQ*.patch"

pkg_postinst() {
	elog "The XanMod team strongly suggests the use of updated CPU microcodes"
	elog "with its kernels. For details: see:"
	elog "https://wiki.gentoo.org/wiki/Microcode"
	kernel-2_pkg_postinst
}

pkg_postrm() {
	kernel-2_pkg_postrm
}
