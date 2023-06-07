Return-Path: <linux-security-module-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F0122C77B7A
	for <linux-security-module@archiver.kernel.org>; Wed,  7 Jun 2023 23:54:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230046AbjFGXyM convert rfc822-to-8bit (ORCPT
        <rfc822;linux-security-module@archiver.kernel.org>);
        Wed, 7 Jun 2023 19:54:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53252 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230445AbjFGXyK (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Wed, 7 Jun 2023 19:54:10 -0400
Received: from mx0a-00082601.pphosted.com (mx0a-00082601.pphosted.com [67.231.145.42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ADB62213A
        for <linux-security-module@vger.kernel.org>; Wed,  7 Jun 2023 16:54:06 -0700 (PDT)
Received: from pps.filterd (m0044010.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 357HfwOG009959
        for <linux-security-module@vger.kernel.org>; Wed, 7 Jun 2023 16:54:06 -0700
Received: from maileast.thefacebook.com ([163.114.130.16])
        by mx0a-00082601.pphosted.com (PPS) with ESMTPS id 3r2a89tp4q-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
        for <linux-security-module@vger.kernel.org>; Wed, 07 Jun 2023 16:54:06 -0700
Received: from twshared52565.14.frc2.facebook.com (2620:10d:c0a8:1c::11) by
 mail.thefacebook.com (2620:10d:c0a8:82::e) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.23; Wed, 7 Jun 2023 16:54:04 -0700
Received: by devbig019.vll3.facebook.com (Postfix, from userid 137359)
        id 7C21A32857D16; Wed,  7 Jun 2023 16:53:52 -0700 (PDT)
From:   Andrii Nakryiko <andrii@kernel.org>
To:     <bpf@vger.kernel.org>
CC:     <linux-security-module@vger.kernel.org>, <keescook@chromium.org>,
        <brauner@kernel.org>, <lennart@poettering.net>,
        <cyphar@cyphar.com>, <luto@kernel.org>, <kernel-team@meta.com>
Subject: [PATCH v2 bpf-next 00/18] BPF token
Date:   Wed, 7 Jun 2023 16:53:34 -0700
Message-ID: <20230607235352.1723243-1-andrii@kernel.org>
X-Mailer: git-send-email 2.34.1
X-FB-Internal: Safe
Content-Type: text/plain
X-Proofpoint-GUID: LYz_oUnxK3uzi2NG-E2zFLJGqjU341_8
X-Proofpoint-ORIG-GUID: LYz_oUnxK3uzi2NG-E2zFLJGqjU341_8
Content-Transfer-Encoding: 8BIT
X-Proofpoint-UnRewURL: 0 URL was un-rewritten
MIME-Version: 1.0
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.573,FMLib:17.11.176.26
 definitions=2023-06-07_13,2023-06-07_01,2023-05-22_02
Precedence: bulk
List-ID: <linux-security-module.vger.kernel.org>

This patch set introduces new BPF object, BPF token, which allows to delegate
a subset of BPF functionality from privileged system-wide daemon (e.g.,
systemd or any other container manager) to a *trusted* unprivileged
application. Trust is the key here. This functionality is not about allowing
unconditional unprivileged BPF usage. Establishing trust, though, is
completely up to the discretion of respective privileged application that
would create a BPF token.

The main motivation for BPF token is a desire to enable containerized
BPF applications to be used together with user namespaces. This is currently
impossible, as CAP_BPF, required for BPF subsystem usage, cannot be namespaced
or sandboxed, as a general rule. E.g., tracing BPF programs, thanks to BPF
helpers like bpf_probe_read_kernel() and bpf_probe_read_user() can safely read
arbitrary memory, and it's impossible to ensure that they only read memory of
processes belonging to any given namespace. This means that it's impossible to
have namespace-aware CAP_BPF capability, and as such another mechanism to
allow safe usage of BPF functionality is necessary. BPF token and delegation
of it to a trusted unprivileged applications is such mechanism. Kernel makes
no assumption about what "trusted" constitutes in any particular case, and
it's up to specific privileged applications and their surrounding
infrastructure to decide that. What kernel provides is a set of APIs to create
and tune BPF token, and pass it around to privileged BPF commands that are
creating new BPF objects like BPF programs, BPF maps, etc.

Previous attempt at addressing this very same problem ([0]) attempted to
utilize authoritative LSM approach, but was conclusively rejected by upstream
LSM maintainers. BPF token concept is not changing anything about LSM
approach, but can be combined with LSM hooks for very fine-grained security
policy. Some ideas about making BPF token more convenient to use with LSM (in
particular custom BPF LSM programs) was briefly described in recent LSF/MM/BPF
2023 presentation ([1]). E.g., an ability to specify user-provided data
(context), which in combination with BPF LSM would allow implementing a very
dynamic and fine-granular custom security policies on top of BPF token. In the
interest of minimizing API surface area discussions this is going to be
added in follow up patches, as it's not essential to the fundamental concept
of delegatable BPF token.

It should be noted that BPF token is conceptually quite similar to the idea of
/dev/bpf device file, proposed by Song a while ago ([2]). The biggest
difference is the idea of using virtual anon_inode file to hold BPF token and
allowing multiple independent instances of them, each with its own set of
restrictions. BPF pinning solves the problem of exposing such BPF token
through file system (BPF FS, in this case) for cases where transferring FDs
over Unix domain sockets is not convenient. And also, crucially, BPF token
approach is not using any special stateful task-scoped flags. Instead, bpf()
syscall accepts token_fd parameters explicitly for each relevant BPF command.
This addresses main concerns brought up during the /dev/bpf discussion, and
fits better with overall BPF subsystem design.

This patch set adds a basic minimum of functionality to make BPF token useful
and to discuss API and functionality. Currently only low-level libbpf APIs
support passing BPF token around, allowing to test kernel functionality, but
for the most part is not sufficient for real-world applications, which
typically use high-level libbpf APIs based on `struct bpf_object` type. This
was done with the intent to limit the size of patch set and concentrate on
mostly kernel-side changes. All the necessary plumbing for libbpf will be sent
as a separate follow up patch set kernel support makes it upstream.

Another part that should happen once kernel-side BPF token is established, is
a set of conventions between applications (e.g., systemd), tools (e.g.,
bpftool), and libraries (e.g., libbpf) about sharing BPF tokens through BPF FS
at well-defined locations to allow applications take advantage of this in
automatic fashion without explicit code changes on BPF application's side.
But I'd like to postpone this discussion to after BPF token concept lands.

  [0] https://lore.kernel.org/bpf/20230412043300.360803-1-andrii@kernel.org/
  [1] http://vger.kernel.org/bpfconf2023_material/Trusted_unprivileged_BPF_LSFMM2023.pdf
  [2] https://lore.kernel.org/bpf/20190627201923.2589391-2-songliubraving@fb.com/

v1->v2:
  - fix build failures on Kconfig with CONFIG_BPF_SYSCALL unset;
  - drop BPF_F_TOKEN_UNKNOWN_* flags and simplify UAPI (Stanislav).

Andrii Nakryiko (18):
  bpf: introduce BPF token object
  libbpf: add bpf_token_create() API
  selftests/bpf: add BPF_TOKEN_CREATE test
  bpf: move unprivileged checks into map_create() and bpf_prog_load()
  bpf: inline map creation logic in map_create() function
  bpf: centralize permissions checks for all BPF map types
  bpf: add BPF token support to BPF_MAP_CREATE command
  libbpf: add BPF token support to bpf_map_create() API
  selftests/bpf: add BPF token-enabled test for BPF_MAP_CREATE command
  bpf: add BPF token support to BPF_BTF_LOAD command
  libbpf: add BPF token support to bpf_btf_load() API
  selftests/bpf: add BPF token-enabled BPF_BTF_LOAD selftest
  bpf: keep BPF_PROG_LOAD permission checks clear of validations
  bpf: add BPF token support to BPF_PROG_LOAD command
  bpf: take into account BPF token when fetching helper protos
  bpf: consistenly use BPF token throughout BPF verifier logic
  libbpf: add BPF token support to bpf_prog_load() API
  selftests/bpf: add BPF token-enabled BPF_PROG_LOAD tests

 drivers/media/rc/bpf-lirc.c                   |   2 +-
 include/linux/bpf.h                           |  70 ++-
 include/linux/filter.h                        |   2 +-
 include/uapi/linux/bpf.h                      |  37 ++
 kernel/bpf/Makefile                           |   2 +-
 kernel/bpf/arraymap.c                         |   2 +-
 kernel/bpf/bloom_filter.c                     |   3 -
 kernel/bpf/bpf_local_storage.c                |   3 -
 kernel/bpf/bpf_struct_ops.c                   |   3 -
 kernel/bpf/cgroup.c                           |   6 +-
 kernel/bpf/core.c                             |   3 +-
 kernel/bpf/cpumap.c                           |   4 -
 kernel/bpf/devmap.c                           |   3 -
 kernel/bpf/hashtab.c                          |   6 -
 kernel/bpf/helpers.c                          |   6 +-
 kernel/bpf/inode.c                            |  26 ++
 kernel/bpf/lpm_trie.c                         |   3 -
 kernel/bpf/queue_stack_maps.c                 |   4 -
 kernel/bpf/reuseport_array.c                  |   3 -
 kernel/bpf/stackmap.c                         |   3 -
 kernel/bpf/syscall.c                          | 401 ++++++++++++++----
 kernel/bpf/token.c                            | 136 ++++++
 kernel/bpf/verifier.c                         |  13 +-
 kernel/trace/bpf_trace.c                      |   2 +-
 net/core/filter.c                             |  36 +-
 net/core/sock_map.c                           |   4 -
 net/ipv4/bpf_tcp_ca.c                         |   2 +-
 net/netfilter/nf_bpf_link.c                   |   2 +-
 net/xdp/xskmap.c                              |   4 -
 tools/include/uapi/linux/bpf.h                |  39 ++
 tools/lib/bpf/bpf.c                           |  32 +-
 tools/lib/bpf/bpf.h                           |  24 +-
 tools/lib/bpf/libbpf.map                      |   1 +
 .../selftests/bpf/prog_tests/libbpf_probes.c  |   4 +
 .../selftests/bpf/prog_tests/libbpf_str.c     |   6 +
 .../testing/selftests/bpf/prog_tests/token.c  | 260 ++++++++++++
 .../bpf/prog_tests/unpriv_bpf_disabled.c      |   6 +-
 37 files changed, 975 insertions(+), 188 deletions(-)
 create mode 100644 kernel/bpf/token.c
 create mode 100644 tools/testing/selftests/bpf/prog_tests/token.c

-- 
2.34.1

