Received: from mail-05.mail-europe.com (mail-05.mail-europe.com [85.9.206.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CA60B42BC3C
	for <linux-security-module@vger.kernel.org>; Tue, 14 Jul 2026 21:08:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=85.9.206.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784063301; cv=none; b=bjayIgz1gM5m2nqrdCMT41rR/8TfEtsBUZ8hWl7FeDkToWm6UaPPw5Jl1W3HWtyp9XnbDtJnvcgNjM3d+lSkofI7wazU+iNxN5BXO+S+JVbW/IlEVuVPk0MNSVhJFYqm1aA+THL1gLuPIyZz3IKTqOPGmEQOtNAZmEpP+N3iAho=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784063301; c=relaxed/simple;
	bh=QTH9q2cuu1FtK6U2WuC2GP/g6zQL+IUuCr/38N9WYok=;
	h=Date:To:From:Cc:Subject:Message-ID:MIME-Version:Content-Type; b=CJS9RAF+cYY8dEdLbkPHYrAiL/7nM6UsANBlMmZDsJhEoyIuwoUXtRJj+Z2rsWeLgMXKX1jgAwsgp34Y48GGWrB83n/6aS+F91K6uJzZnYHKABgF1wi7D5nhPciZ20uq8pSHXdZujWXASB0I1ZXRl73ajK9ItJmoArV494Apr7o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=kengrimes.com; spf=pass smtp.mailfrom=kengrimes.com; dkim=pass (2048-bit key) header.d=kengrimes.com header.i=@kengrimes.com header.b=iqoUal3X; arc=none smtp.client-ip=85.9.206.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=kengrimes.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kengrimes.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kengrimes.com header.i=@kengrimes.com header.b="iqoUal3X"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kengrimes.com;
	s=protonmail3; t=1784063279; x=1784322479;
	bh=QTH9q2cuu1FtK6U2WuC2GP/g6zQL+IUuCr/38N9WYok=;
	h=Date:To:From:Cc:Subject:Message-ID:Feedback-ID:From:To:Cc:Date:
	 Subject:Reply-To:Feedback-ID:Message-ID:BIMI-Selector;
	b=iqoUal3XUVyQ/F3kd1xl1TAlO/Gbt9eKb7O9q1LjWYQejw4iq7fpRfl5Hc4sLsUoe
	 mCEdVedzp4WPHNSTnke8t8bXjH/8tI/pwhm4u1eVMahee1q4SQIhzrOT5p0A6s1pBp
	 n04Kj2/sHhCS4ICXtpRHfza9o/PkrDKQSW6WXVna7KE4LhVb2A854q1tDcLECHTDLN
	 hmT+iTCrboJt5zWhV67zheJ2llVF8xFIepC4bWgwAfuod2AQmHc/j2jIU8FojfpIaR
	 TsrpdnvXCZMHLjySv6R0hxnpIyhxuwkrlmk7AZ0zABcxtgLQ1LXV/s2UCbNA6IouXZ
	 vMgL9MwcI0Csg==
Date: Tue, 14 Jul 2026 21:07:56 +0000
To: "linux-security-module@vger.kernel.org" <linux-security-module@vger.kernel.org>
From: Ken Grimes <ken@kengrimes.com>
Cc: =?utf-8?Q?Micka=C3=ABl_Sala=C3=BCn?= <mic@digikod.net>, =?utf-8?Q?G=C3=BCnther_Noack?= <gnoack@google.com>
Subject: [BUG] Landlock denies LANDLOCK_ACCESS_FS_EXECUTE despite a correctly-anchored PathBeneath rule (contradicts selftest layout1.execute)
Message-ID: <P8RYlSi7C7oum2lk1F3PumYSvaUyd0Sn_VwUYAcWwjbQxSt_Rau30Aa1oLIEnLZ2iafcsFmEG5C4LTeBWCyd9vCx94FYeTX_OJdHoERcWSI=@kengrimes.com>
Feedback-ID: 26299838:user:proton
X-Pm-Message-ID: 4c668eba6f887a2398318d112f663acccf28c97e
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; protocol="application/pgp-signature"; micalg=pgp-sha512; boundary="------5557844a03d65874aeb395be5c33d83a882950f6f3227c988e34e53309cb6be2"; charset=utf-8

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--------5557844a03d65874aeb395be5c33d83a882950f6f3227c988e34e53309cb6be2
Content-Type: multipart/mixed;boundary=---------------------a13646fe735a870407e4d755e7eb20de

-----------------------a13646fe735a870407e4d755e7eb20de
Content-Type: multipart/alternative;boundary=---------------------cbd988f438d6f82217af6e33ea3165a6

-----------------------cbd988f438d6f82217af6e33ea3165a6
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain;charset=utf-8

Hey all, this is my first bug report for linux. The issue was discovered=C2=
=A0
alongside=C2=A0llm-assisted coding on a downstream project. The=C2=A0
investigation/testing of the bug was a mostly manual process so I could=C2=
=A0
be sure this was something real. Please let me know if I can provide any
further details or assistance. Hope this is helpful, thank you for all of =
your
hard work!


Summary
-------

On Linux 7.1.3 (Fedora 44, Landlock ABI version 9), a minimal, correctly
constructed Landlock ruleset denies execve()/execveat() of that file with
EACCES. This directly contradicts the expected behavior of the official
selftest assertion: tools/testing/selftests/landlock/fs_test.c's
TEST_F_FORK(layout1, execute), specifically the file1_s1d2 case,
expects exactly this shape of rule to permit execution
(test_execute(_metadata, 0, file1_s1d2)).

This was confirmed two ways: a minimal standalone reproduction (below),
and by building and running your own unmodified
tools/testing/selftests/landlock/fs_test.c from the v7.1.3 tag (exact
match to the running kernel and its kernel-headers package) against this
kernel. layout1.execute fails on this kernel:

=C2=A0 =C2=A0 # =C2=A0RUN =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 layout1.execu=
te ...
=C2=A0 =C2=A0 # fs_test.c:1949:execute:Expected err ? -1 : 0 (0) =3D=3D ex=
ecve(path, argv, NULL) (-1)
=C2=A0 =C2=A0 # fs_test.c:1951:execute:Failed to execute "tmp/s1d1/s1d2/f1=
": Permission denied
=C2=A0 =C2=A0 # execute: Test terminated by assertion
=C2=A0 =C2=A0 # =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0FAIL =C2=A0layout1.execu=
te
=C2=A0 =C2=A0 not ok 29 layout1.execute

tmp/s1d1/s1d2/f1 is file1_s1d2 is the file living directly inside
dir_s1d2, which is the directory the test's own PathBeneath rule
anchors on (rules[0] =3D { .path =3D dir_s1d2, .access =3D
LANDLOCK_ACCESS_FS_EXECUTE }). The failing assertion is
test_execute(_metadata, 0, file1_s1d2) (fs_test.c:1949 in the v7.1.3
tree, quoted below). The test's author expects this call to succeed
(err =3D=3D 0), and on this kernel it doesn't. Full raw test output is
attached (official-selftest-output.log).

Relevant excerpt of the actual test body (identical across the v7.1.3
tag and current master):

=C2=A0 =C2=A0 TEST_F_FORK(layout1, execute)
=C2=A0 =C2=A0 {
=C2=A0 =C2=A0 const struct rule rules[] =3D {
=C2=A0 =C2=A0 {
=C2=A0 =C2=A0 .path =3D dir_s1d2,
=C2=A0 =C2=A0 .access =3D LANDLOCK_ACCESS_FS_EXECUTE,
=C2=A0 =C2=A0 },
=C2=A0 =C2=A0 {},
=C2=A0 =C2=A0 };

=C2=A0 =C2=A0 copy_file(_metadata, bin_true, file1_s1d1);
=C2=A0 =C2=A0 copy_file(_metadata, bin_true, file1_s1d2);
=C2=A0 =C2=A0 copy_file(_metadata, bin_true, file1_s1d3);

=C2=A0 =C2=A0 /* Checks before file1_s1d1 being denied. */
=C2=A0 =C2=A0 test_execute(_metadata, 0, file1_s1d1);
=C2=A0 =C2=A0 test_check_exec(_metadata, 0, file1_s1d1);

=C2=A0 =C2=A0 enforce_fs(_metadata, rules[0].access, rules);

=C2=A0 =C2=A0 ASSERT_EQ(0, test_open(dir_s1d1, O_RDONLY));
=C2=A0 =C2=A0 ASSERT_EQ(0, test_open(file1_s1d1, O_RDONLY));
=C2=A0 =C2=A0 test_execute(_metadata, EACCES, file1_s1d1);
=C2=A0 =C2=A0 test_check_exec(_metadata, EACCES, file1_s1d1);

=C2=A0 =C2=A0 ASSERT_EQ(0, test_open(dir_s1d2, O_RDONLY));
=C2=A0 =C2=A0 ASSERT_EQ(0, test_open(file1_s1d2, O_RDONLY));
=C2=A0 =C2=A0 test_execute(_metadata, 0, file1_s1d2); =C2=A0 =C2=A0 =C2=A0=
 =C2=A0/* <-- fails here */
=C2=A0 =C2=A0 test_check_exec(_metadata, 0, file1_s1d2);
=C2=A0 =C2=A0 ...

(Reproducing the official fixture required running from a
world-writable directory: prepare_layout_opt() calls disable_caps()
which drops CAP_DAC_OVERRIDE from the otherwise-root test process,
before creating its working directory, so it must be run from
somewhere an unprivileged-DAC root can still write, e.g. under /tmp
directly. This is unrelated to the actual bug, just a note for anyone
else reproducing it.)

Environment
-----------

- Kernel: 7.1.3-200.fc44.x86_64 (Fedora 44 Workstation)
- Landlock ABI version: 9 (via landlock_create_ruleset(NULL, 0,
=C2=A0 LANDLOCK_CREATE_RULESET_VERSION))
- kernel-headers package: kernel-headers-7.1.3-200.fc44.x86_64
=C2=A0 (exact version match to the running kernel; the reproduction below =
was
=C2=A0 built against these headers)
- No root/CAP_SYS_ADMIN involved anywhere in the reproduction -- Landlock
=C2=A0 is unprivileged by design, and this reproduces identically as an
=C2=A0 ordinary user.

Reproduction
------------

Official selftest (strongest evidence):

=C2=A0 =C2=A0 $ git clone --branch v7.1.3 --depth 1 https://github.com/gre=
gkh/linux
=C2=A0 =C2=A0 $ cd linux/tools/testing/selftests/landlock
=C2=A0 =C2=A0 $ gcc -O0 -g -Wall -o fs_test fs_test.c -lcap -lpthread
=C2=A0 =C2=A0 $ gcc -O0 -o true true.c
=C2=A0 =C2=A0 $ mkdir -p /tmp/lltest && chmod 1777 /tmp/lltest
=C2=A0 =C2=A0 $ cp fs_test true /tmp/lltest/ && cd /tmp/lltest
=C2=A0 =C2=A0 $ sudo ./fs_test -f layout1 -t execute

(Run from a world-writable directory. See the note above about
disable_caps()) Full output attached as official-selftest-output.log.

Minimal standalone reproduction (self-contained, no external
dependencies beyond libc and the system's own <linux/landlock.h>,
unprivileged, attached as repro.c):

=C2=A0 =C2=A0 /*
=C2=A0 =C2=A0 =C2=A0* Minimal standalone reproduction of a Landlock EXECUT=
E-right denial that
=C2=A0 =C2=A0 =C2=A0* contradicts the upstream kernel's own selftest expec=
tation.
=C2=A0 =C2=A0 =C2=A0*
=C2=A0 =C2=A0 =C2=A0* This mirrors tools/testing/selftests/landlock/fs_tes=
t.c's
=C2=A0 =C2=A0 =C2=A0* TEST_F_FORK(layout1, execute) -- specifically the fi=
le1_s1d2 case: a
=C2=A0 =C2=A0 =C2=A0* PathBeneath rule granting only LANDLOCK_ACCESS_FS_EX=
ECUTE, anchored on a
=C2=A0 =C2=A0 =C2=A0* directory, is expected to permit execve() of a file =
directly inside that
=C2=A0 =C2=A0 =C2=A0* directory (upstream asserts test_execute(_metadata, =
0, file1_s1d2), i.e.
=C2=A0 =C2=A0 =C2=A0* "no error"). On this kernel it is denied with EACCES=
 instead.
=C2=A0 =C2=A0 =C2=A0*
=C2=A0 =C2=A0 =C2=A0* No root/CAP_SYS_ADMIN required -- Landlock is design=
ed for unprivileged
=C2=A0 =C2=A0 =C2=A0* use, and this reproduces the same way as an ordinary=
 user.
=C2=A0 =C2=A0 =C2=A0*
=C2=A0 =C2=A0 =C2=A0* Build: =C2=A0 gcc -O0 -g -Wall -o repro repro.c
=C2=A0 =C2=A0 =C2=A0* Run: =C2=A0 =C2=A0 ./repro
=C2=A0 =C2=A0 =C2=A0*
=C2=A0 =C2=A0 =C2=A0* Observed on: Linux 7.1.3-200.fc44.x86_64 (Fedora 44 =
Workstation),
=C2=A0 =C2=A0 =C2=A0* Landlock ABI version 9 (per landlock_create_ruleset(=
NULL, 0,
=C2=A0 =C2=A0 =C2=A0* LANDLOCK_CREATE_RULESET_VERSION)).
=C2=A0 =C2=A0 =C2=A0*/

=C2=A0 =C2=A0 #define _GNU_SOURCE
=C2=A0 =C2=A0 #include <errno.h>
=C2=A0 =C2=A0 #include <fcntl.h>
=C2=A0 =C2=A0 #include <linux/landlock.h>
=C2=A0 =C2=A0 #include <stdio.h>
=C2=A0 =C2=A0 #include <stdlib.h>
=C2=A0 =C2=A0 #include <string.h>
=C2=A0 =C2=A0 #include <sys/prctl.h>
=C2=A0 =C2=A0 #include <sys/stat.h>
=C2=A0 =C2=A0 #include <sys/syscall.h>
=C2=A0 =C2=A0 #include <sys/wait.h>
=C2=A0 =C2=A0 #include <unistd.h>

=C2=A0 =C2=A0 static int landlock_create_ruleset(const struct landlock_rul=
eset_attr *attr,
=C2=A0 =C2=A0 =C2=A0 =C2=A0size_t size, __u32 flags)
=C2=A0 =C2=A0 {
=C2=A0 =C2=A0 return syscall(SYS_landlock_create_ruleset, attr, size, flag=
s);
=C2=A0 =C2=A0 }

=C2=A0 =C2=A0 static int landlock_add_rule(int ruleset_fd, enum landlock_r=
ule_type type,
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0const void *attr, __u32 flags)
=C2=A0 =C2=A0 {
=C2=A0 =C2=A0 return syscall(SYS_landlock_add_rule, ruleset_fd, type, attr=
, flags);
=C2=A0 =C2=A0 }

=C2=A0 =C2=A0 static int landlock_restrict_self(int ruleset_fd, __u32 flag=
s)
=C2=A0 =C2=A0 {
=C2=A0 =C2=A0 return syscall(SYS_landlock_restrict_self, ruleset_fd, flags=
);
=C2=A0 =C2=A0 }

=C2=A0 =C2=A0 static void die(const char *what)
=C2=A0 =C2=A0 {
=C2=A0 =C2=A0 fprintf(stderr, "%s: %s\n", what, strerror(errno));
=C2=A0 =C2=A0 exit(1);
=C2=A0 =C2=A0 }

=C2=A0 =C2=A0 /* Runs `path` via a fresh execve() in a child, prints and r=
eturns its result. */
=C2=A0 =C2=A0 static int try_execve(const char *path)
=C2=A0 =C2=A0 {
=C2=A0 =C2=A0 pid_t pid =3D fork();
=C2=A0 =C2=A0 if (pid < 0)
=C2=A0 =C2=A0 die("fork");
=C2=A0 =C2=A0 if (pid =3D=3D 0) {
=C2=A0 =C2=A0 char *const argv[] =3D { (char *)path, NULL };
=C2=A0 =C2=A0 execve(path, argv, NULL);
=C2=A0 =C2=A0 /* Only reached on failure. */
=C2=A0 =C2=A0 fprintf(stderr, "execve(%s) failed: %s (errno %d)\n", path,
=C2=A0 =C2=A0 strerror(errno), errno);
=C2=A0 =C2=A0 _exit(1);
=C2=A0 =C2=A0 }
=C2=A0 =C2=A0 int status;
=C2=A0 =C2=A0 waitpid(pid, &status, 0);
=C2=A0 =C2=A0 if (WIFEXITED(status) && WEXITSTATUS(status) =3D=3D 0)
=C2=A0 =C2=A0 return 0;
=C2=A0 =C2=A0 return 1;
=C2=A0 =C2=A0 }

=C2=A0 =C2=A0 int main(void)
=C2=A0 =C2=A0 {
=C2=A0 =C2=A0 int abi =3D landlock_create_ruleset(NULL, 0,
=C2=A0 =C2=A0 =C2=A0 LANDLOCK_CREATE_RULESET_VERSION);
=C2=A0 =C2=A0 printf("Landlock ABI version: %d\n", abi);
=C2=A0 =C2=A0 if (abi < 0)
=C2=A0 =C2=A0 die("landlock_create_ruleset(VERSION)");

=C2=A0 =C2=A0 /* Build tmp/dir/exe, matching layout1's dir_s1d2/file1_s1d2=
 shape:
=C2=A0 =C2=A0 * a rule anchored on the parent directory, target file direc=
tly
=C2=A0 =C2=A0 * inside it (zero levels of extra nesting). */
=C2=A0 =C2=A0 if (mkdir("repro-dir", 0700) < 0 && errno !=3D EEXIST)
=C2=A0 =C2=A0 die("mkdir repro-dir");

=C2=A0 =C2=A0 /* Copy /bin/true in as our target executable. */
=C2=A0 =C2=A0 {
=C2=A0 =C2=A0 char cmd[256];
=C2=A0 =C2=A0 snprintf(cmd, sizeof(cmd),
=C2=A0 =C2=A0 "cp /bin/true repro-dir/exe && chmod 755 repro-dir/exe");
=C2=A0 =C2=A0 if (system(cmd) !=3D 0)
=C2=A0 =C2=A0 die("cp /bin/true");
=C2=A0 =C2=A0 }

=C2=A0 =C2=A0 /* Baseline: confirm it executes fine before Landlock is inv=
olved. */
=C2=A0 =C2=A0 if (try_execve("repro-dir/exe") !=3D 0) {
=C2=A0 =C2=A0 fprintf(stderr, "baseline execve failed even without Landloc=
k -- "
=C2=A0 =C2=A0 "environment problem, not a Landlock issue\n");
=C2=A0 =C2=A0 return 1;
=C2=A0 =C2=A0 }
=C2=A0 =C2=A0 printf("Baseline (no Landlock): execve succeeded, as expecte=
d.\n");

=C2=A0 =C2=A0 /* Minimal ruleset: EXECUTE only, matching the official self=
test's
=C2=A0 =C2=A0 * rules[0].access =3D LANDLOCK_ACCESS_FS_EXECUTE for layout1=
.execute. */
=C2=A0 =C2=A0 struct landlock_ruleset_attr ruleset_attr =3D {
=C2=A0 =C2=A0 .handled_access_fs =3D LANDLOCK_ACCESS_FS_EXECUTE,
=C2=A0 =C2=A0 };
=C2=A0 =C2=A0 int ruleset_fd =3D landlock_create_ruleset(&ruleset_attr,
=C2=A0 =C2=A0 =C2=A0sizeof(ruleset_attr), 0);
=C2=A0 =C2=A0 if (ruleset_fd < 0)
=C2=A0 =C2=A0 die("landlock_create_ruleset");

=C2=A0 =C2=A0 int parent_fd =3D open("repro-dir", O_PATH);
=C2=A0 =C2=A0 if (parent_fd < 0)
=C2=A0 =C2=A0 die("open repro-dir O_PATH");

=C2=A0 =C2=A0 struct landlock_path_beneath_attr path_beneath =3D {
=C2=A0 =C2=A0 .allowed_access =3D LANDLOCK_ACCESS_FS_EXECUTE,
=C2=A0 =C2=A0 .parent_fd =3D parent_fd,
=C2=A0 =C2=A0 };
=C2=A0 =C2=A0 if (landlock_add_rule(ruleset_fd, LANDLOCK_RULE_PATH_BENEATH=
,
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 &path_beneath, 0) !=3D 0)
=C2=A0 =C2=A0 die("landlock_add_rule");
=C2=A0 =C2=A0 close(parent_fd);

=C2=A0 =C2=A0 if (prctl(PR_SET_NO_NEW_PRIVS, 1, 0, 0, 0) !=3D 0)
=C2=A0 =C2=A0 die("prctl(PR_SET_NO_NEW_PRIVS)");

=C2=A0 =C2=A0 if (landlock_restrict_self(ruleset_fd, 0) !=3D 0)
=C2=A0 =C2=A0 die("landlock_restrict_self");
=C2=A0 =C2=A0 close(ruleset_fd);

=C2=A0 =C2=A0 printf("Landlock ruleset installed: EXECUTE-only, one PathBe=
neath "
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 "rule anchored on repro-dir (the target=
 file's own parent).\n");

=C2=A0 =C2=A0 int result =3D try_execve("repro-dir/exe");
=C2=A0 =C2=A0 if (result =3D=3D 0) {
=C2=A0 =C2=A0 printf("PASS: execve succeeded, as the upstream selftest "
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 "(layout1.execute, file1_s1d2 case) exp=
ects.\n");
=C2=A0 =C2=A0 } else {
=C2=A0 =C2=A0 printf("FAIL: execve was denied (EACCES) despite an "
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 "explicit, correctly-anchored PathBenea=
th rule "
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 "granting LANDLOCK_ACCESS_FS_EXECUTE on=
 the file's "
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 "own parent directory -- this contradic=
ts "
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 "tools/testing/selftests/landlock/fs_te=
st.c's "
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 "TEST_F_FORK(layout1, execute) expectat=
ion for the "
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 "file1_s1d2 case.\n");
=C2=A0 =C2=A0 }

=C2=A0 =C2=A0 system("rm -rf repro-dir");
=C2=A0 =C2=A0 return result;
=C2=A0 =C2=A0 }

Build and run:

=C2=A0 =C2=A0 $ gcc -O0 -g -Wall -o repro repro.c
=C2=A0 =C2=A0 $ ./repro
=C2=A0 =C2=A0 Landlock ABI version: 9
=C2=A0 =C2=A0 Baseline (no Landlock): execve succeeded, as expected.
=C2=A0 =C2=A0 Landlock ruleset installed: EXECUTE-only, one PathBeneath ru=
le anchored on repro-dir (the target file's own parent).
=C2=A0 =C2=A0 execve(repro-dir/exe) failed: Permission denied (errno 13)
=C2=A0 =C2=A0 FAIL: execve was denied (EACCES) despite an explicit, correc=
tly-anchored PathBeneath rule granting LANDLOCK_ACCESS_FS_EXECUTE on the f=
ile's own parent directory -- this contradicts tools/testing/selftests/lan=
dlock/fs_test.c's TEST_F_FORK(layout1, execute) expectation for the file1_=
s1d2 case.

What was ruled out before concluding this is a kernel-level issue
--------------------------------------------------------------------

This was investigated extensively in the course of debugging a real
downstream project (a Rust codebase using the landlock crate 0.4.5) that
hit this exact denial. Before concluding it's a kernel bug rather than a
userspace mistake, the following were each tested and ruled out as the
cause:

1. SELinux: this host runs SELinux Enforcing, but the reproduction
=C2=A0 =C2=A0above runs entirely under the interactive shell's unconfined_=
t
=C2=A0 =C2=A0domain, and the identical target file executes fine via a pla=
in
=C2=A0 =C2=A0(non-Landlock) execve() beforehand in the same process. Only =
adding
=C2=A0 =C2=A0the Landlock ruleset flips the result to EACCES.

2. IPE (Integrity Policy Enforcement): enforce=3D1 on this host, but
=C2=A0 =C2=A0/sys/kernel/security/ipe/policies/ is empty (no policy loaded=
), and
=C2=A0 =C2=A0no IPE-related denial appears in the audit log around the fai=
lure. A
=C2=A0 =C2=A0plain execve() of the same file with no Landlock domain activ=
e
=C2=A0 =C2=A0succeeds, which would not be the case if IPE were uncondition=
ally
=C2=A0 =C2=A0denying this file.

3. Kernel lockdown mode: active at "integrity" level on this host
=C2=A0 =C2=A0(Fedora enables this automatically under Secure Boot), but lo=
ckdown's
=C2=A0 =C2=A0documented restrictions (module signing, /dev/mem, hibernatio=
n,
=C2=A0 =C2=A0kexec, debugfs, etc.) govern kernel-image-integrity operation=
s, not
=C2=A0 =C2=A0ordinary unprivileged LSM policy decisions like Landlock's ow=
n
=C2=A0 =C2=A0filesystem checks, and no documented interaction between the =
two was
=C2=A0 =C2=A0found.

4. tmpfs vs. a real on-disk filesystem: the denial reproduces
=C2=A0 =C2=A0identically whether the target directory is on tmpfs (/tmp) o=
r a
=C2=A0 =C2=A0real on-disk btrfs filesystem (the root filesystem).

5. fd-based (execveat+AT_EMPTY_PATH) vs. path-based execve(): both
=C2=A0 =C2=A0fail identically; this is not specific to executing via an
=C2=A0 =C2=A0already-open file descriptor.

6. Direct child vs. nested subdirectory: a file nested one level deeper
=C2=A0 =C2=A0than the anchored rule fails identically to a file directly i=
n the
=C2=A0 =C2=A0anchored directory.

7. O_PATH vs. plain open() for the rule's anchor fd: no difference
=C2=A0 =C2=A0(the landlock Rust crate's own documentation warns plain File=
 opens
=C2=A0 =C2=A0"may lead to unexpected errors," but explicitly testing O_PAT=
H
=C2=A0 =C2=A0produced the identical denial).

8. Ruleset rights breadth: tested with handled_access_fs as EXECUTE-only
=C2=A0 =C2=A0as the full V3-era 15-right set, and with an additional expli=
cit
=C2=A0 =C2=A0file-anchored rule (correctly scoped to file-valid rights) la=
yered
=C2=A0 =C2=A0alongside the directory rule. All identical.

9. landlock_ruleset_attr struct size: tested with the struct passed at
=C2=A0 =C2=A024, 32, 48, and 64 bytes (padded with zeroed trailing fields,=
 in case
=C2=A0 =C2=A0of an extensible-struct zero-extension gap for fields introdu=
ced at
=C2=A0 =C2=A0ABI 8/9, e.g. the quiet_access_fs/quiet_access_net/quiet_scop=
ed
=C2=A0 =C2=A0fields added around ABI 7-9). No difference; the reproduction
=C2=A0 =C2=A0attached uses sizeof(ruleset_attr) against the real system he=
ader,
=C2=A0 =C2=A0matching upstream selftest convention exactly.

10. Published errata: checked all three currently-documented entries
=C2=A0 =C2=A0 in security/landlock/errata/ (disconnected-directory rename
=C2=A0 =C2=A0 widening, TCP socket protocol misclassification, thread sign=
al
=C2=A0 =C2=A0 scoping). None match this symptom.

11. Direct read of security/landlock/fs.c on torvalds/linux master:
=C2=A0 =C2=A0 the is_access_to_paths_allowed()/current_check_access_path()=
/
=C2=A0 =C2=A0 hook_file_open() hierarchy-walk logic appears correct for th=
is
=C2=A0 =C2=A0 simple case (walk starts at the target file's own dentry, ch=
ecks
=C2=A0 =C2=A0 find_rule() at each level while walking up via dget_parent()=
, and
=C2=A0 =C2=A0 our anchor is exactly one level up). No obvious logic defect=
 was
=C2=A0 =C2=A0 found by inspection, which is part of why this is being repo=
rted
=C2=A0 =C2=A0 rather than fixed downstream.

Given (11), if the master-branch logic is correct, this may already be
fixed in a tree newer than 7.1.3, or the regression window may be
narrow but as of this exact kernel, the discrepancy against the
selftest's own documented expectation is real and reproducible.

Impact
------

This affects any unprivileged (or privileged, self-restricting) process
that installs a minimal Landlock domain and then tries to execute a file
covered by a directory-anchored rule which is a common Landlock usage
pattern (matching the kernel's own selftest).
Downstream, it silently breaks a security-hardening code path
(Landlock-based filesystem confinement for a privileged process tree)
with no diagnostic beyond a generic EACCES, since the process attempting
the exec has already dropped privileges and cannot meaningfully report
the failure back to a parent through advanced means.

Request
-------

Could you confirm whether this is a known/already-fixed issue, and if
not, whether the attached reproduction is sufficient to track down the
regression? Let me know if you'd like me test a patch or provide more
instrumentation from this exact kernel build if useful.

Attachments
-----------

- repro.c - minimal standalone reproduction (also inlined above)
- official-selftest-output.log - full raw TAP output from running the
=C2=A0 unmodified v7.1.3 fs_test -f layout1 -t execute against this kernel
-----------------------cbd988f438d6f82217af6e33ea3165a6
Content-Type: multipart/related;boundary=---------------------101ee20b184380757c033b7287959fa5

-----------------------101ee20b184380757c033b7287959fa5
Content-Type: text/html;charset=utf-8
Content-Transfer-Encoding: base64

PGRpdiBzdHlsZT0iZm9udC1mYW1pbHk6IEFyaWFsLCBzYW5zLXNlcmlmOyBmb250LXNpemU6IDE0
cHg7Ij48ZGl2PjxzcGFuPkhleSBhbGwsIHRoaXMgaXMgbXkgZmlyc3QgYnVnIHJlcG9ydCBmb3Ig
bGludXguIFRoZSBpc3N1ZSB3YXMgZGlzY292ZXJlZCZuYnNwOzwvc3Bhbj48L2Rpdj48ZGl2Pjxz
cGFuPmFsb25nc2lkZSZuYnNwO2xsbS1hc3Npc3RlZCBjb2Rpbmcgb24gYSBkb3duc3RyZWFtIHBy
b2plY3QuIFRoZSZuYnNwOzwvc3Bhbj48L2Rpdj48ZGl2PjxzcGFuPmludmVzdGlnYXRpb24vdGVz
dGluZyBvZiB0aGUgYnVnIHdhcyBhIG1vc3RseSBtYW51YWwgcHJvY2VzcyBzbyBJIGNvdWxkJm5i
c3A7PC9zcGFuPjwvZGl2PjxkaXY+PHNwYW4+YmUgc3VyZSB0aGlzIHdhcyBzb21ldGhpbmcgcmVh
bC4gUGxlYXNlIGxldCBtZSBrbm93IGlmIEkgY2FuIHByb3ZpZGUgYW55PC9zcGFuPjwvZGl2Pjxk
aXY+PHNwYW4+ZnVydGhlciBkZXRhaWxzIG9yIGFzc2lzdGFuY2UuIEhvcGUgdGhpcyBpcyBoZWxw
ZnVsLCB0aGFuayB5b3UgZm9yIGFsbCBvZiB5b3VyPC9zcGFuPjwvZGl2PjxkaXY+PHNwYW4+aGFy
ZCB3b3JrITwvc3Bhbj48L2Rpdj48ZGl2PjxzcGFuPjxicj48L3NwYW4+PC9kaXY+PGRpdj48c3Bh
bj5TdW1tYXJ5PC9zcGFuPjwvZGl2PjxkaXY+PHNwYW4+LS0tLS0tLTwvc3Bhbj48L2Rpdj48ZGl2
Pjxicj48L2Rpdj48ZGl2PjxzcGFuPk9uIExpbnV4IDcuMS4zIChGZWRvcmEgNDQsIExhbmRsb2Nr
IEFCSSB2ZXJzaW9uIDkpLCBhIG1pbmltYWwsIGNvcnJlY3RseTwvc3Bhbj48L2Rpdj48ZGl2Pjxz
cGFuPmNvbnN0cnVjdGVkIExhbmRsb2NrIHJ1bGVzZXQgZGVuaWVzIGV4ZWN2ZSgpL2V4ZWN2ZWF0
KCkgb2YgdGhhdCBmaWxlIHdpdGg8L3NwYW4+PC9kaXY+PGRpdj48c3Bhbj5FQUNDRVMuIFRoaXMg
ZGlyZWN0bHkgY29udHJhZGljdHMgdGhlIGV4cGVjdGVkIGJlaGF2aW9yIG9mIHRoZSBvZmZpY2lh
bDwvc3Bhbj48L2Rpdj48ZGl2PjxzcGFuPnNlbGZ0ZXN0IGFzc2VydGlvbjogdG9vbHMvdGVzdGlu
Zy9zZWxmdGVzdHMvbGFuZGxvY2svZnNfdGVzdC5jJ3M8L3NwYW4+PC9kaXY+PGRpdj48c3Bhbj5U
RVNUX0ZfRk9SSyhsYXlvdXQxLCBleGVjdXRlKSwgc3BlY2lmaWNhbGx5IHRoZSBmaWxlMV9zMWQy
IGNhc2UsPC9zcGFuPjwvZGl2PjxkaXY+PHNwYW4+ZXhwZWN0cyBleGFjdGx5IHRoaXMgc2hhcGUg
b2YgcnVsZSB0byBwZXJtaXQgZXhlY3V0aW9uPC9zcGFuPjwvZGl2PjxkaXY+PHNwYW4+KHRlc3Rf
ZXhlY3V0ZShfbWV0YWRhdGEsIDAsIGZpbGUxX3MxZDIpKS48L3NwYW4+PC9kaXY+PGRpdj48YnI+
PC9kaXY+PGRpdj48c3Bhbj5UaGlzIHdhcyBjb25maXJtZWQgdHdvIHdheXM6IGEgbWluaW1hbCBz
dGFuZGFsb25lIHJlcHJvZHVjdGlvbiAoYmVsb3cpLDwvc3Bhbj48L2Rpdj48ZGl2PjxzcGFuPmFu
ZCBieSBidWlsZGluZyBhbmQgcnVubmluZyB5b3VyIG93biB1bm1vZGlmaWVkIDwvc3Bhbj48L2Rp
dj48ZGl2PjxzcGFuPnRvb2xzL3Rlc3Rpbmcvc2VsZnRlc3RzL2xhbmRsb2NrL2ZzX3Rlc3QuYyBm
cm9tIHRoZSB2Ny4xLjMgdGFnIChleGFjdDwvc3Bhbj48L2Rpdj48ZGl2PjxzcGFuPm1hdGNoIHRv
IHRoZSBydW5uaW5nIGtlcm5lbCBhbmQgaXRzIGtlcm5lbC1oZWFkZXJzIHBhY2thZ2UpIGFnYWlu
c3QgdGhpczwvc3Bhbj48L2Rpdj48ZGl2PjxzcGFuPmtlcm5lbC4gbGF5b3V0MS5leGVjdXRlIGZh
aWxzIG9uIHRoaXMga2VybmVsOjwvc3Bhbj48L2Rpdj48ZGl2Pjxicj48L2Rpdj48ZGl2PjxzcGFu
PiZuYnNwOyAmbmJzcDsgIyAmbmJzcDtSVU4gJm5ic3A7ICZuYnNwOyAmbmJzcDsgJm5ic3A7ICZu
YnNwOyBsYXlvdXQxLmV4ZWN1dGUgLi4uPC9zcGFuPjwvZGl2PjxkaXY+PHNwYW4+Jm5ic3A7ICZu
YnNwOyAjIGZzX3Rlc3QuYzoxOTQ5OmV4ZWN1dGU6RXhwZWN0ZWQgZXJyID8gLTEgOiAwICgwKSA9
PSBleGVjdmUocGF0aCwgYXJndiwgTlVMTCkgKC0xKTwvc3Bhbj48L2Rpdj48ZGl2PjxzcGFuPiZu
YnNwOyAmbmJzcDsgIyBmc190ZXN0LmM6MTk1MTpleGVjdXRlOkZhaWxlZCB0byBleGVjdXRlICJ0
bXAvczFkMS9zMWQyL2YxIjogUGVybWlzc2lvbiBkZW5pZWQ8L3NwYW4+PC9kaXY+PGRpdj48c3Bh
bj4mbmJzcDsgJm5ic3A7ICMgZXhlY3V0ZTogVGVzdCB0ZXJtaW5hdGVkIGJ5IGFzc2VydGlvbjwv
c3Bhbj48L2Rpdj48ZGl2PjxzcGFuPiZuYnNwOyAmbmJzcDsgIyAmbmJzcDsgJm5ic3A7ICZuYnNw
OyAmbmJzcDsgJm5ic3A7RkFJTCAmbmJzcDtsYXlvdXQxLmV4ZWN1dGU8L3NwYW4+PC9kaXY+PGRp
dj48c3Bhbj4mbmJzcDsgJm5ic3A7IG5vdCBvayAyOSBsYXlvdXQxLmV4ZWN1dGU8L3NwYW4+PC9k
aXY+PGRpdj48YnI+PC9kaXY+PGRpdj48c3Bhbj50bXAvczFkMS9zMWQyL2YxIGlzIGZpbGUxX3Mx
ZDIgaXMgdGhlIGZpbGUgbGl2aW5nIGRpcmVjdGx5IGluc2lkZTwvc3Bhbj48L2Rpdj48ZGl2Pjxz
cGFuPmRpcl9zMWQyLCB3aGljaCBpcyB0aGUgZGlyZWN0b3J5IHRoZSB0ZXN0J3Mgb3duIFBhdGhC
ZW5lYXRoIHJ1bGU8L3NwYW4+PC9kaXY+PGRpdj48c3Bhbj5hbmNob3JzIG9uIChydWxlc1swXSA9
IHsgLnBhdGggPSBkaXJfczFkMiwgLmFjY2VzcyA9PC9zcGFuPjwvZGl2PjxkaXY+PHNwYW4+TEFO
RExPQ0tfQUNDRVNTX0ZTX0VYRUNVVEUgfSkuIFRoZSBmYWlsaW5nIGFzc2VydGlvbiBpczwvc3Bh
bj48L2Rpdj48ZGl2PjxzcGFuPnRlc3RfZXhlY3V0ZShfbWV0YWRhdGEsIDAsIGZpbGUxX3MxZDIp
IChmc190ZXN0LmM6MTk0OSBpbiB0aGUgdjcuMS4zPC9zcGFuPjwvZGl2PjxkaXY+PHNwYW4+dHJl
ZSwgcXVvdGVkIGJlbG93KS4gVGhlIHRlc3QncyBhdXRob3IgZXhwZWN0cyB0aGlzIGNhbGwgdG8g
c3VjY2VlZDwvc3Bhbj48L2Rpdj48ZGl2PjxzcGFuPihlcnIgPT0gMCksIGFuZCBvbiB0aGlzIGtl
cm5lbCBpdCBkb2Vzbid0LiBGdWxsIHJhdyB0ZXN0IG91dHB1dCBpczwvc3Bhbj48L2Rpdj48ZGl2
PjxzcGFuPmF0dGFjaGVkIChvZmZpY2lhbC1zZWxmdGVzdC1vdXRwdXQubG9nKS48L3NwYW4+PC9k
aXY+PGRpdj48YnI+PC9kaXY+PGRpdj48c3Bhbj5SZWxldmFudCBleGNlcnB0IG9mIHRoZSBhY3R1
YWwgdGVzdCBib2R5IChpZGVudGljYWwgYWNyb3NzIHRoZSB2Ny4xLjM8L3NwYW4+PC9kaXY+PGRp
dj48c3Bhbj50YWcgYW5kIGN1cnJlbnQgbWFzdGVyKTo8L3NwYW4+PC9kaXY+PGRpdj48YnI+PC9k
aXY+PGRpdj48c3Bhbj4mbmJzcDsgJm5ic3A7IFRFU1RfRl9GT1JLKGxheW91dDEsIGV4ZWN1dGUp
PC9zcGFuPjwvZGl2PjxkaXY+PHNwYW4+Jm5ic3A7ICZuYnNwOyB7PC9zcGFuPjwvZGl2PjxkaXY+
PHNwYW4+Jm5ic3A7ICZuYnNwOyAJY29uc3Qgc3RydWN0IHJ1bGUgcnVsZXNbXSA9IHs8L3NwYW4+
PC9kaXY+PGRpdj48c3Bhbj4mbmJzcDsgJm5ic3A7IAkJezwvc3Bhbj48L2Rpdj48ZGl2PjxzcGFu
PiZuYnNwOyAmbmJzcDsgCQkJLnBhdGggPSBkaXJfczFkMiw8L3NwYW4+PC9kaXY+PGRpdj48c3Bh
bj4mbmJzcDsgJm5ic3A7IAkJCS5hY2Nlc3MgPSBMQU5ETE9DS19BQ0NFU1NfRlNfRVhFQ1VURSw8
L3NwYW4+PC9kaXY+PGRpdj48c3Bhbj4mbmJzcDsgJm5ic3A7IAkJfSw8L3NwYW4+PC9kaXY+PGRp
dj48c3Bhbj4mbmJzcDsgJm5ic3A7IAkJe30sPC9zcGFuPjwvZGl2PjxkaXY+PHNwYW4+Jm5ic3A7
ICZuYnNwOyAJfTs8L3NwYW4+PC9kaXY+PGRpdj48YnI+PC9kaXY+PGRpdj48c3Bhbj4mbmJzcDsg
Jm5ic3A7IAljb3B5X2ZpbGUoX21ldGFkYXRhLCBiaW5fdHJ1ZSwgZmlsZTFfczFkMSk7PC9zcGFu
PjwvZGl2PjxkaXY+PHNwYW4+Jm5ic3A7ICZuYnNwOyAJY29weV9maWxlKF9tZXRhZGF0YSwgYmlu
X3RydWUsIGZpbGUxX3MxZDIpOzwvc3Bhbj48L2Rpdj48ZGl2PjxzcGFuPiZuYnNwOyAmbmJzcDsg
CWNvcHlfZmlsZShfbWV0YWRhdGEsIGJpbl90cnVlLCBmaWxlMV9zMWQzKTs8L3NwYW4+PC9kaXY+
PGRpdj48YnI+PC9kaXY+PGRpdj48c3Bhbj4mbmJzcDsgJm5ic3A7IAkvKiBDaGVja3MgYmVmb3Jl
IGZpbGUxX3MxZDEgYmVpbmcgZGVuaWVkLiAqLzwvc3Bhbj48L2Rpdj48ZGl2PjxzcGFuPiZuYnNw
OyAmbmJzcDsgCXRlc3RfZXhlY3V0ZShfbWV0YWRhdGEsIDAsIGZpbGUxX3MxZDEpOzwvc3Bhbj48
L2Rpdj48ZGl2PjxzcGFuPiZuYnNwOyAmbmJzcDsgCXRlc3RfY2hlY2tfZXhlYyhfbWV0YWRhdGEs
IDAsIGZpbGUxX3MxZDEpOzwvc3Bhbj48L2Rpdj48ZGl2Pjxicj48L2Rpdj48ZGl2PjxzcGFuPiZu
YnNwOyAmbmJzcDsgCWVuZm9yY2VfZnMoX21ldGFkYXRhLCBydWxlc1swXS5hY2Nlc3MsIHJ1bGVz
KTs8L3NwYW4+PC9kaXY+PGRpdj48YnI+PC9kaXY+PGRpdj48c3Bhbj4mbmJzcDsgJm5ic3A7IAlB
U1NFUlRfRVEoMCwgdGVzdF9vcGVuKGRpcl9zMWQxLCBPX1JET05MWSkpOzwvc3Bhbj48L2Rpdj48
ZGl2PjxzcGFuPiZuYnNwOyAmbmJzcDsgCUFTU0VSVF9FUSgwLCB0ZXN0X29wZW4oZmlsZTFfczFk
MSwgT19SRE9OTFkpKTs8L3NwYW4+PC9kaXY+PGRpdj48c3Bhbj4mbmJzcDsgJm5ic3A7IAl0ZXN0
X2V4ZWN1dGUoX21ldGFkYXRhLCBFQUNDRVMsIGZpbGUxX3MxZDEpOzwvc3Bhbj48L2Rpdj48ZGl2
PjxzcGFuPiZuYnNwOyAmbmJzcDsgCXRlc3RfY2hlY2tfZXhlYyhfbWV0YWRhdGEsIEVBQ0NFUywg
ZmlsZTFfczFkMSk7PC9zcGFuPjwvZGl2PjxkaXY+PGJyPjwvZGl2PjxkaXY+PHNwYW4+Jm5ic3A7
ICZuYnNwOyAJQVNTRVJUX0VRKDAsIHRlc3Rfb3BlbihkaXJfczFkMiwgT19SRE9OTFkpKTs8L3Nw
YW4+PC9kaXY+PGRpdj48c3Bhbj4mbmJzcDsgJm5ic3A7IAlBU1NFUlRfRVEoMCwgdGVzdF9vcGVu
KGZpbGUxX3MxZDIsIE9fUkRPTkxZKSk7PC9zcGFuPjwvZGl2PjxkaXY+PHNwYW4+Jm5ic3A7ICZu
YnNwOyAJdGVzdF9leGVjdXRlKF9tZXRhZGF0YSwgMCwgZmlsZTFfczFkMik7ICZuYnNwOyAmbmJz
cDsgJm5ic3A7ICZuYnNwOy8qICZsdDstLSBmYWlscyBoZXJlICovPC9zcGFuPjwvZGl2PjxkaXY+
PHNwYW4+Jm5ic3A7ICZuYnNwOyAJdGVzdF9jaGVja19leGVjKF9tZXRhZGF0YSwgMCwgZmlsZTFf
czFkMik7PC9zcGFuPjwvZGl2PjxkaXY+PHNwYW4+Jm5ic3A7ICZuYnNwOyAJLi4uPC9zcGFuPjwv
ZGl2PjxkaXY+PGJyPjwvZGl2PjxkaXY+PHNwYW4+KFJlcHJvZHVjaW5nIHRoZSBvZmZpY2lhbCBm
aXh0dXJlIHJlcXVpcmVkIHJ1bm5pbmcgZnJvbSBhPC9zcGFuPjwvZGl2PjxkaXY+PHNwYW4+d29y
bGQtd3JpdGFibGUgZGlyZWN0b3J5OiBwcmVwYXJlX2xheW91dF9vcHQoKSBjYWxscyBkaXNhYmxl
X2NhcHMoKTwvc3Bhbj48L2Rpdj48ZGl2PjxzcGFuPndoaWNoIGRyb3BzIENBUF9EQUNfT1ZFUlJJ
REUgZnJvbSB0aGUgb3RoZXJ3aXNlLXJvb3QgdGVzdCBwcm9jZXNzLDwvc3Bhbj48L2Rpdj48ZGl2
PjxzcGFuPmJlZm9yZSBjcmVhdGluZyBpdHMgd29ya2luZyBkaXJlY3RvcnksIHNvIGl0IG11c3Qg
YmUgcnVuIGZyb208L3NwYW4+PC9kaXY+PGRpdj48c3Bhbj5zb21ld2hlcmUgYW4gdW5wcml2aWxl
Z2VkLURBQyByb290IGNhbiBzdGlsbCB3cml0ZSwgZS5nLiB1bmRlciAvdG1wPC9zcGFuPjwvZGl2
PjxkaXY+PHNwYW4+ZGlyZWN0bHkuIFRoaXMgaXMgdW5yZWxhdGVkIHRvIHRoZSBhY3R1YWwgYnVn
LCBqdXN0IGEgbm90ZSBmb3IgYW55b25lPC9zcGFuPjwvZGl2PjxkaXY+PHNwYW4+ZWxzZSByZXBy
b2R1Y2luZyBpdC4pPC9zcGFuPjwvZGl2PjxkaXY+PGJyPjwvZGl2PjxkaXY+PHNwYW4+RW52aXJv
bm1lbnQ8L3NwYW4+PC9kaXY+PGRpdj48c3Bhbj4tLS0tLS0tLS0tLTwvc3Bhbj48L2Rpdj48ZGl2
Pjxicj48L2Rpdj48ZGl2PjxzcGFuPi0gS2VybmVsOiA3LjEuMy0yMDAuZmM0NC54ODZfNjQgKEZl
ZG9yYSA0NCBXb3Jrc3RhdGlvbik8L3NwYW4+PC9kaXY+PGRpdj48c3Bhbj4tIExhbmRsb2NrIEFC
SSB2ZXJzaW9uOiA5ICh2aWEgbGFuZGxvY2tfY3JlYXRlX3J1bGVzZXQoTlVMTCwgMCw8L3NwYW4+
PC9kaXY+PGRpdj48c3Bhbj4mbmJzcDsgTEFORExPQ0tfQ1JFQVRFX1JVTEVTRVRfVkVSU0lPTikp
PC9zcGFuPjwvZGl2PjxkaXY+PHNwYW4+LSBrZXJuZWwtaGVhZGVycyBwYWNrYWdlOiBrZXJuZWwt
aGVhZGVycy03LjEuMy0yMDAuZmM0NC54ODZfNjQ8L3NwYW4+PC9kaXY+PGRpdj48c3Bhbj4mbmJz
cDsgKGV4YWN0IHZlcnNpb24gbWF0Y2ggdG8gdGhlIHJ1bm5pbmcga2VybmVsOyB0aGUgcmVwcm9k
dWN0aW9uIGJlbG93IHdhczwvc3Bhbj48L2Rpdj48ZGl2PjxzcGFuPiZuYnNwOyBidWlsdCBhZ2Fp
bnN0IHRoZXNlIGhlYWRlcnMpPC9zcGFuPjwvZGl2PjxkaXY+PHNwYW4+LSBObyByb290L0NBUF9T
WVNfQURNSU4gaW52b2x2ZWQgYW55d2hlcmUgaW4gdGhlIHJlcHJvZHVjdGlvbiAtLSBMYW5kbG9j
azwvc3Bhbj48L2Rpdj48ZGl2PjxzcGFuPiZuYnNwOyBpcyB1bnByaXZpbGVnZWQgYnkgZGVzaWdu
LCBhbmQgdGhpcyByZXByb2R1Y2VzIGlkZW50aWNhbGx5IGFzIGFuPC9zcGFuPjwvZGl2PjxkaXY+
PHNwYW4+Jm5ic3A7IG9yZGluYXJ5IHVzZXIuPC9zcGFuPjwvZGl2PjxkaXY+PGJyPjwvZGl2Pjxk
aXY+PHNwYW4+UmVwcm9kdWN0aW9uPC9zcGFuPjwvZGl2PjxkaXY+PHNwYW4+LS0tLS0tLS0tLS0t
PC9zcGFuPjwvZGl2PjxkaXY+PGJyPjwvZGl2PjxkaXY+PHNwYW4+T2ZmaWNpYWwgc2VsZnRlc3Qg
KHN0cm9uZ2VzdCBldmlkZW5jZSk6PC9zcGFuPjwvZGl2PjxkaXY+PGJyPjwvZGl2PjxkaXY+PHNw
YW4+Jm5ic3A7ICZuYnNwOyAkIGdpdCBjbG9uZSAtLWJyYW5jaCB2Ny4xLjMgLS1kZXB0aCAxIDxh
IHRhcmdldD0iX2JsYW5rIiByZWw9Im5vcmVmZXJyZXIgbm9mb2xsb3cgbm9vcGVuZXIiIGhyZWY9
Imh0dHBzOi8vZ2l0aHViLmNvbS9ncmVna2gvbGludXgiPmh0dHBzOi8vZ2l0aHViLmNvbS9ncmVn
a2gvbGludXg8L2E+PC9zcGFuPjwvZGl2PjxkaXY+PHNwYW4+Jm5ic3A7ICZuYnNwOyAkIGNkIGxp
bnV4L3Rvb2xzL3Rlc3Rpbmcvc2VsZnRlc3RzL2xhbmRsb2NrPC9zcGFuPjwvZGl2PjxkaXY+PHNw
YW4+Jm5ic3A7ICZuYnNwOyAkIGdjYyAtTzAgLWcgLVdhbGwgLW8gZnNfdGVzdCBmc190ZXN0LmMg
LWxjYXAgLWxwdGhyZWFkPC9zcGFuPjwvZGl2PjxkaXY+PHNwYW4+Jm5ic3A7ICZuYnNwOyAkIGdj
YyAtTzAgLW8gdHJ1ZSB0cnVlLmM8L3NwYW4+PC9kaXY+PGRpdj48c3Bhbj4mbmJzcDsgJm5ic3A7
ICQgbWtkaXIgLXAgL3RtcC9sbHRlc3QgJmFtcDsmYW1wOyBjaG1vZCAxNzc3IC90bXAvbGx0ZXN0
PC9zcGFuPjwvZGl2PjxkaXY+PHNwYW4+Jm5ic3A7ICZuYnNwOyAkIGNwIGZzX3Rlc3QgdHJ1ZSAv
dG1wL2xsdGVzdC8gJmFtcDsmYW1wOyBjZCAvdG1wL2xsdGVzdDwvc3Bhbj48L2Rpdj48ZGl2Pjxz
cGFuPiZuYnNwOyAmbmJzcDsgJCBzdWRvIC4vZnNfdGVzdCAtZiBsYXlvdXQxIC10IGV4ZWN1dGU8
L3NwYW4+PC9kaXY+PGRpdj48YnI+PC9kaXY+PGRpdj48c3Bhbj4oUnVuIGZyb20gYSB3b3JsZC13
cml0YWJsZSBkaXJlY3RvcnkuIFNlZSB0aGUgbm90ZSBhYm92ZSBhYm91dDwvc3Bhbj48L2Rpdj48
ZGl2PjxzcGFuPmRpc2FibGVfY2FwcygpKSBGdWxsIG91dHB1dCBhdHRhY2hlZCBhcyBvZmZpY2lh
bC1zZWxmdGVzdC1vdXRwdXQubG9nLjwvc3Bhbj48L2Rpdj48ZGl2Pjxicj48L2Rpdj48ZGl2Pjxz
cGFuPk1pbmltYWwgc3RhbmRhbG9uZSByZXByb2R1Y3Rpb24gKHNlbGYtY29udGFpbmVkLCBubyBl
eHRlcm5hbDwvc3Bhbj48L2Rpdj48ZGl2PjxzcGFuPmRlcGVuZGVuY2llcyBiZXlvbmQgbGliYyBh
bmQgdGhlIHN5c3RlbSdzIG93biAmbHQ7bGludXgvbGFuZGxvY2suaCZndDssPC9zcGFuPjwvZGl2
PjxkaXY+PHNwYW4+dW5wcml2aWxlZ2VkLCBhdHRhY2hlZCBhcyByZXByby5jKTo8L3NwYW4+PC9k
aXY+PGRpdj48YnI+PC9kaXY+PGRpdj48c3Bhbj4mbmJzcDsgJm5ic3A7IC8qPC9zcGFuPjwvZGl2
PjxkaXY+PHNwYW4+Jm5ic3A7ICZuYnNwOyAmbmJzcDsqIE1pbmltYWwgc3RhbmRhbG9uZSByZXBy
b2R1Y3Rpb24gb2YgYSBMYW5kbG9jayBFWEVDVVRFLXJpZ2h0IGRlbmlhbCB0aGF0PC9zcGFuPjwv
ZGl2PjxkaXY+PHNwYW4+Jm5ic3A7ICZuYnNwOyAmbmJzcDsqIGNvbnRyYWRpY3RzIHRoZSB1cHN0
cmVhbSBrZXJuZWwncyBvd24gc2VsZnRlc3QgZXhwZWN0YXRpb24uPC9zcGFuPjwvZGl2PjxkaXY+
PHNwYW4+Jm5ic3A7ICZuYnNwOyAmbmJzcDsqPC9zcGFuPjwvZGl2PjxkaXY+PHNwYW4+Jm5ic3A7
ICZuYnNwOyAmbmJzcDsqIFRoaXMgbWlycm9ycyB0b29scy90ZXN0aW5nL3NlbGZ0ZXN0cy9sYW5k
bG9jay9mc190ZXN0LmMnczwvc3Bhbj48L2Rpdj48ZGl2PjxzcGFuPiZuYnNwOyAmbmJzcDsgJm5i
c3A7KiBURVNUX0ZfRk9SSyhsYXlvdXQxLCBleGVjdXRlKSAtLSBzcGVjaWZpY2FsbHkgdGhlIGZp
bGUxX3MxZDIgY2FzZTogYTwvc3Bhbj48L2Rpdj48ZGl2PjxzcGFuPiZuYnNwOyAmbmJzcDsgJm5i
c3A7KiBQYXRoQmVuZWF0aCBydWxlIGdyYW50aW5nIG9ubHkgTEFORExPQ0tfQUNDRVNTX0ZTX0VY
RUNVVEUsIGFuY2hvcmVkIG9uIGE8L3NwYW4+PC9kaXY+PGRpdj48c3Bhbj4mbmJzcDsgJm5ic3A7
ICZuYnNwOyogZGlyZWN0b3J5LCBpcyBleHBlY3RlZCB0byBwZXJtaXQgZXhlY3ZlKCkgb2YgYSBm
aWxlIGRpcmVjdGx5IGluc2lkZSB0aGF0PC9zcGFuPjwvZGl2PjxkaXY+PHNwYW4+Jm5ic3A7ICZu
YnNwOyAmbmJzcDsqIGRpcmVjdG9yeSAodXBzdHJlYW0gYXNzZXJ0cyB0ZXN0X2V4ZWN1dGUoX21l
dGFkYXRhLCAwLCBmaWxlMV9zMWQyKSwgaS5lLjwvc3Bhbj48L2Rpdj48ZGl2PjxzcGFuPiZuYnNw
OyAmbmJzcDsgJm5ic3A7KiAibm8gZXJyb3IiKS4gT24gdGhpcyBrZXJuZWwgaXQgaXMgZGVuaWVk
IHdpdGggRUFDQ0VTIGluc3RlYWQuPC9zcGFuPjwvZGl2PjxkaXY+PHNwYW4+Jm5ic3A7ICZuYnNw
OyAmbmJzcDsqPC9zcGFuPjwvZGl2PjxkaXY+PHNwYW4+Jm5ic3A7ICZuYnNwOyAmbmJzcDsqIE5v
IHJvb3QvQ0FQX1NZU19BRE1JTiByZXF1aXJlZCAtLSBMYW5kbG9jayBpcyBkZXNpZ25lZCBmb3Ig
dW5wcml2aWxlZ2VkPC9zcGFuPjwvZGl2PjxkaXY+PHNwYW4+Jm5ic3A7ICZuYnNwOyAmbmJzcDsq
IHVzZSwgYW5kIHRoaXMgcmVwcm9kdWNlcyB0aGUgc2FtZSB3YXkgYXMgYW4gb3JkaW5hcnkgdXNl
ci48L3NwYW4+PC9kaXY+PGRpdj48c3Bhbj4mbmJzcDsgJm5ic3A7ICZuYnNwOyo8L3NwYW4+PC9k
aXY+PGRpdj48c3Bhbj4mbmJzcDsgJm5ic3A7ICZuYnNwOyogQnVpbGQ6ICZuYnNwOyBnY2MgLU8w
IC1nIC1XYWxsIC1vIHJlcHJvIHJlcHJvLmM8L3NwYW4+PC9kaXY+PGRpdj48c3Bhbj4mbmJzcDsg
Jm5ic3A7ICZuYnNwOyogUnVuOiAmbmJzcDsgJm5ic3A7IC4vcmVwcm88L3NwYW4+PC9kaXY+PGRp
dj48c3Bhbj4mbmJzcDsgJm5ic3A7ICZuYnNwOyo8L3NwYW4+PC9kaXY+PGRpdj48c3Bhbj4mbmJz
cDsgJm5ic3A7ICZuYnNwOyogT2JzZXJ2ZWQgb246IExpbnV4IDcuMS4zLTIwMC5mYzQ0Lng4Nl82
NCAoRmVkb3JhIDQ0IFdvcmtzdGF0aW9uKSw8L3NwYW4+PC9kaXY+PGRpdj48c3Bhbj4mbmJzcDsg
Jm5ic3A7ICZuYnNwOyogTGFuZGxvY2sgQUJJIHZlcnNpb24gOSAocGVyIGxhbmRsb2NrX2NyZWF0
ZV9ydWxlc2V0KE5VTEwsIDAsPC9zcGFuPjwvZGl2PjxkaXY+PHNwYW4+Jm5ic3A7ICZuYnNwOyAm
bmJzcDsqIExBTkRMT0NLX0NSRUFURV9SVUxFU0VUX1ZFUlNJT04pKS48L3NwYW4+PC9kaXY+PGRp
dj48c3Bhbj4mbmJzcDsgJm5ic3A7ICZuYnNwOyovPC9zcGFuPjwvZGl2PjxkaXY+PGJyPjwvZGl2
PjxkaXY+PHNwYW4+Jm5ic3A7ICZuYnNwOyAjZGVmaW5lIF9HTlVfU09VUkNFPC9zcGFuPjwvZGl2
PjxkaXY+PHNwYW4+Jm5ic3A7ICZuYnNwOyAjaW5jbHVkZSAmbHQ7ZXJybm8uaCZndDs8L3NwYW4+
PC9kaXY+PGRpdj48c3Bhbj4mbmJzcDsgJm5ic3A7ICNpbmNsdWRlICZsdDtmY250bC5oJmd0Ozwv
c3Bhbj48L2Rpdj48ZGl2PjxzcGFuPiZuYnNwOyAmbmJzcDsgI2luY2x1ZGUgJmx0O2xpbnV4L2xh
bmRsb2NrLmgmZ3Q7PC9zcGFuPjwvZGl2PjxkaXY+PHNwYW4+Jm5ic3A7ICZuYnNwOyAjaW5jbHVk
ZSAmbHQ7c3RkaW8uaCZndDs8L3NwYW4+PC9kaXY+PGRpdj48c3Bhbj4mbmJzcDsgJm5ic3A7ICNp
bmNsdWRlICZsdDtzdGRsaWIuaCZndDs8L3NwYW4+PC9kaXY+PGRpdj48c3Bhbj4mbmJzcDsgJm5i
c3A7ICNpbmNsdWRlICZsdDtzdHJpbmcuaCZndDs8L3NwYW4+PC9kaXY+PGRpdj48c3Bhbj4mbmJz
cDsgJm5ic3A7ICNpbmNsdWRlICZsdDtzeXMvcHJjdGwuaCZndDs8L3NwYW4+PC9kaXY+PGRpdj48
c3Bhbj4mbmJzcDsgJm5ic3A7ICNpbmNsdWRlICZsdDtzeXMvc3RhdC5oJmd0Ozwvc3Bhbj48L2Rp
dj48ZGl2PjxzcGFuPiZuYnNwOyAmbmJzcDsgI2luY2x1ZGUgJmx0O3N5cy9zeXNjYWxsLmgmZ3Q7
PC9zcGFuPjwvZGl2PjxkaXY+PHNwYW4+Jm5ic3A7ICZuYnNwOyAjaW5jbHVkZSAmbHQ7c3lzL3dh
aXQuaCZndDs8L3NwYW4+PC9kaXY+PGRpdj48c3Bhbj4mbmJzcDsgJm5ic3A7ICNpbmNsdWRlICZs
dDt1bmlzdGQuaCZndDs8L3NwYW4+PC9kaXY+PGRpdj48YnI+PC9kaXY+PGRpdj48c3Bhbj4mbmJz
cDsgJm5ic3A7IHN0YXRpYyBpbnQgbGFuZGxvY2tfY3JlYXRlX3J1bGVzZXQoY29uc3Qgc3RydWN0
IGxhbmRsb2NrX3J1bGVzZXRfYXR0ciAqYXR0ciw8L3NwYW4+PC9kaXY+PGRpdj48c3Bhbj4mbmJz
cDsgJm5ic3A7IAkJCQkgJm5ic3A7ICZuYnNwO3NpemVfdCBzaXplLCBfX3UzMiBmbGFncyk8L3Nw
YW4+PC9kaXY+PGRpdj48c3Bhbj4mbmJzcDsgJm5ic3A7IHs8L3NwYW4+PC9kaXY+PGRpdj48c3Bh
bj4mbmJzcDsgJm5ic3A7IAlyZXR1cm4gc3lzY2FsbChTWVNfbGFuZGxvY2tfY3JlYXRlX3J1bGVz
ZXQsIGF0dHIsIHNpemUsIGZsYWdzKTs8L3NwYW4+PC9kaXY+PGRpdj48c3Bhbj4mbmJzcDsgJm5i
c3A7IH08L3NwYW4+PC9kaXY+PGRpdj48YnI+PC9kaXY+PGRpdj48c3Bhbj4mbmJzcDsgJm5ic3A7
IHN0YXRpYyBpbnQgbGFuZGxvY2tfYWRkX3J1bGUoaW50IHJ1bGVzZXRfZmQsIGVudW0gbGFuZGxv
Y2tfcnVsZV90eXBlIHR5cGUsPC9zcGFuPjwvZGl2PjxkaXY+PHNwYW4+Jm5ic3A7ICZuYnNwOyAJ
CQkgJm5ic3A7ICZuYnNwOyAmbmJzcDtjb25zdCB2b2lkICphdHRyLCBfX3UzMiBmbGFncyk8L3Nw
YW4+PC9kaXY+PGRpdj48c3Bhbj4mbmJzcDsgJm5ic3A7IHs8L3NwYW4+PC9kaXY+PGRpdj48c3Bh
bj4mbmJzcDsgJm5ic3A7IAlyZXR1cm4gc3lzY2FsbChTWVNfbGFuZGxvY2tfYWRkX3J1bGUsIHJ1
bGVzZXRfZmQsIHR5cGUsIGF0dHIsIGZsYWdzKTs8L3NwYW4+PC9kaXY+PGRpdj48c3Bhbj4mbmJz
cDsgJm5ic3A7IH08L3NwYW4+PC9kaXY+PGRpdj48YnI+PC9kaXY+PGRpdj48c3Bhbj4mbmJzcDsg
Jm5ic3A7IHN0YXRpYyBpbnQgbGFuZGxvY2tfcmVzdHJpY3Rfc2VsZihpbnQgcnVsZXNldF9mZCwg
X191MzIgZmxhZ3MpPC9zcGFuPjwvZGl2PjxkaXY+PHNwYW4+Jm5ic3A7ICZuYnNwOyB7PC9zcGFu
PjwvZGl2PjxkaXY+PHNwYW4+Jm5ic3A7ICZuYnNwOyAJcmV0dXJuIHN5c2NhbGwoU1lTX2xhbmRs
b2NrX3Jlc3RyaWN0X3NlbGYsIHJ1bGVzZXRfZmQsIGZsYWdzKTs8L3NwYW4+PC9kaXY+PGRpdj48
c3Bhbj4mbmJzcDsgJm5ic3A7IH08L3NwYW4+PC9kaXY+PGRpdj48YnI+PC9kaXY+PGRpdj48c3Bh
bj4mbmJzcDsgJm5ic3A7IHN0YXRpYyB2b2lkIGRpZShjb25zdCBjaGFyICp3aGF0KTwvc3Bhbj48
L2Rpdj48ZGl2PjxzcGFuPiZuYnNwOyAmbmJzcDsgezwvc3Bhbj48L2Rpdj48ZGl2PjxzcGFuPiZu
YnNwOyAmbmJzcDsgCWZwcmludGYoc3RkZXJyLCAiJXM6ICVzXG4iLCB3aGF0LCBzdHJlcnJvcihl
cnJubykpOzwvc3Bhbj48L2Rpdj48ZGl2PjxzcGFuPiZuYnNwOyAmbmJzcDsgCWV4aXQoMSk7PC9z
cGFuPjwvZGl2PjxkaXY+PHNwYW4+Jm5ic3A7ICZuYnNwOyB9PC9zcGFuPjwvZGl2PjxkaXY+PGJy
PjwvZGl2PjxkaXY+PHNwYW4+Jm5ic3A7ICZuYnNwOyAvKiBSdW5zIGBwYXRoYCB2aWEgYSBmcmVz
aCBleGVjdmUoKSBpbiBhIGNoaWxkLCBwcmludHMgYW5kIHJldHVybnMgaXRzIHJlc3VsdC4gKi88
L3NwYW4+PC9kaXY+PGRpdj48c3Bhbj4mbmJzcDsgJm5ic3A7IHN0YXRpYyBpbnQgdHJ5X2V4ZWN2
ZShjb25zdCBjaGFyICpwYXRoKTwvc3Bhbj48L2Rpdj48ZGl2PjxzcGFuPiZuYnNwOyAmbmJzcDsg
ezwvc3Bhbj48L2Rpdj48ZGl2PjxzcGFuPiZuYnNwOyAmbmJzcDsgCXBpZF90IHBpZCA9IGZvcmso
KTs8L3NwYW4+PC9kaXY+PGRpdj48c3Bhbj4mbmJzcDsgJm5ic3A7IAlpZiAocGlkICZsdDsgMCk8
L3NwYW4+PC9kaXY+PGRpdj48c3Bhbj4mbmJzcDsgJm5ic3A7IAkJZGllKCJmb3JrIik7PC9zcGFu
PjwvZGl2PjxkaXY+PHNwYW4+Jm5ic3A7ICZuYnNwOyAJaWYgKHBpZCA9PSAwKSB7PC9zcGFuPjwv
ZGl2PjxkaXY+PHNwYW4+Jm5ic3A7ICZuYnNwOyAJCWNoYXIgKmNvbnN0IGFyZ3ZbXSA9IHsgKGNo
YXIgKilwYXRoLCBOVUxMIH07PC9zcGFuPjwvZGl2PjxkaXY+PHNwYW4+Jm5ic3A7ICZuYnNwOyAJ
CWV4ZWN2ZShwYXRoLCBhcmd2LCBOVUxMKTs8L3NwYW4+PC9kaXY+PGRpdj48c3Bhbj4mbmJzcDsg
Jm5ic3A7IAkJLyogT25seSByZWFjaGVkIG9uIGZhaWx1cmUuICovPC9zcGFuPjwvZGl2PjxkaXY+
PHNwYW4+Jm5ic3A7ICZuYnNwOyAJCWZwcmludGYoc3RkZXJyLCAiZXhlY3ZlKCVzKSBmYWlsZWQ6
ICVzIChlcnJubyAlZClcbiIsIHBhdGgsPC9zcGFuPjwvZGl2PjxkaXY+PHNwYW4+Jm5ic3A7ICZu
YnNwOyAJCQlzdHJlcnJvcihlcnJubyksIGVycm5vKTs8L3NwYW4+PC9kaXY+PGRpdj48c3Bhbj4m
bmJzcDsgJm5ic3A7IAkJX2V4aXQoMSk7PC9zcGFuPjwvZGl2PjxkaXY+PHNwYW4+Jm5ic3A7ICZu
YnNwOyAJfTwvc3Bhbj48L2Rpdj48ZGl2PjxzcGFuPiZuYnNwOyAmbmJzcDsgCWludCBzdGF0dXM7
PC9zcGFuPjwvZGl2PjxkaXY+PHNwYW4+Jm5ic3A7ICZuYnNwOyAJd2FpdHBpZChwaWQsICZhbXA7
c3RhdHVzLCAwKTs8L3NwYW4+PC9kaXY+PGRpdj48c3Bhbj4mbmJzcDsgJm5ic3A7IAlpZiAoV0lG
RVhJVEVEKHN0YXR1cykgJmFtcDsmYW1wOyBXRVhJVFNUQVRVUyhzdGF0dXMpID09IDApPC9zcGFu
PjwvZGl2PjxkaXY+PHNwYW4+Jm5ic3A7ICZuYnNwOyAJCXJldHVybiAwOzwvc3Bhbj48L2Rpdj48
ZGl2PjxzcGFuPiZuYnNwOyAmbmJzcDsgCXJldHVybiAxOzwvc3Bhbj48L2Rpdj48ZGl2PjxzcGFu
PiZuYnNwOyAmbmJzcDsgfTwvc3Bhbj48L2Rpdj48ZGl2Pjxicj48L2Rpdj48ZGl2PjxzcGFuPiZu
YnNwOyAmbmJzcDsgaW50IG1haW4odm9pZCk8L3NwYW4+PC9kaXY+PGRpdj48c3Bhbj4mbmJzcDsg
Jm5ic3A7IHs8L3NwYW4+PC9kaXY+PGRpdj48c3Bhbj4mbmJzcDsgJm5ic3A7IAlpbnQgYWJpID0g
bGFuZGxvY2tfY3JlYXRlX3J1bGVzZXQoTlVMTCwgMCw8L3NwYW4+PC9kaXY+PGRpdj48c3Bhbj4m
bmJzcDsgJm5ic3A7IAkJCQkJICZuYnNwOyBMQU5ETE9DS19DUkVBVEVfUlVMRVNFVF9WRVJTSU9O
KTs8L3NwYW4+PC9kaXY+PGRpdj48c3Bhbj4mbmJzcDsgJm5ic3A7IAlwcmludGYoIkxhbmRsb2Nr
IEFCSSB2ZXJzaW9uOiAlZFxuIiwgYWJpKTs8L3NwYW4+PC9kaXY+PGRpdj48c3Bhbj4mbmJzcDsg
Jm5ic3A7IAlpZiAoYWJpICZsdDsgMCk8L3NwYW4+PC9kaXY+PGRpdj48c3Bhbj4mbmJzcDsgJm5i
c3A7IAkJZGllKCJsYW5kbG9ja19jcmVhdGVfcnVsZXNldChWRVJTSU9OKSIpOzwvc3Bhbj48L2Rp
dj48ZGl2Pjxicj48L2Rpdj48ZGl2PjxzcGFuPiZuYnNwOyAmbmJzcDsgCS8qIEJ1aWxkIHRtcC9k
aXIvZXhlLCBtYXRjaGluZyBsYXlvdXQxJ3MgZGlyX3MxZDIvZmlsZTFfczFkMiBzaGFwZTo8L3Nw
YW4+PC9kaXY+PGRpdj48c3Bhbj4mbmJzcDsgJm5ic3A7IAkgKiBhIHJ1bGUgYW5jaG9yZWQgb24g
dGhlIHBhcmVudCBkaXJlY3RvcnksIHRhcmdldCBmaWxlIGRpcmVjdGx5PC9zcGFuPjwvZGl2Pjxk
aXY+PHNwYW4+Jm5ic3A7ICZuYnNwOyAJICogaW5zaWRlIGl0ICh6ZXJvIGxldmVscyBvZiBleHRy
YSBuZXN0aW5nKS4gKi88L3NwYW4+PC9kaXY+PGRpdj48c3Bhbj4mbmJzcDsgJm5ic3A7IAlpZiAo
bWtkaXIoInJlcHJvLWRpciIsIDA3MDApICZsdDsgMCAmYW1wOyZhbXA7IGVycm5vICE9IEVFWElT
VCk8L3NwYW4+PC9kaXY+PGRpdj48c3Bhbj4mbmJzcDsgJm5ic3A7IAkJZGllKCJta2RpciByZXBy
by1kaXIiKTs8L3NwYW4+PC9kaXY+PGRpdj48YnI+PC9kaXY+PGRpdj48c3Bhbj4mbmJzcDsgJm5i
c3A7IAkvKiBDb3B5IC9iaW4vdHJ1ZSBpbiBhcyBvdXIgdGFyZ2V0IGV4ZWN1dGFibGUuICovPC9z
cGFuPjwvZGl2PjxkaXY+PHNwYW4+Jm5ic3A7ICZuYnNwOyAJezwvc3Bhbj48L2Rpdj48ZGl2Pjxz
cGFuPiZuYnNwOyAmbmJzcDsgCQljaGFyIGNtZFsyNTZdOzwvc3Bhbj48L2Rpdj48ZGl2PjxzcGFu
PiZuYnNwOyAmbmJzcDsgCQlzbnByaW50ZihjbWQsIHNpemVvZihjbWQpLDwvc3Bhbj48L2Rpdj48
ZGl2PjxzcGFuPiZuYnNwOyAmbmJzcDsgCQkJICJjcCAvYmluL3RydWUgcmVwcm8tZGlyL2V4ZSAm
YW1wOyZhbXA7IGNobW9kIDc1NSByZXByby1kaXIvZXhlIik7PC9zcGFuPjwvZGl2PjxkaXY+PHNw
YW4+Jm5ic3A7ICZuYnNwOyAJCWlmIChzeXN0ZW0oY21kKSAhPSAwKTwvc3Bhbj48L2Rpdj48ZGl2
PjxzcGFuPiZuYnNwOyAmbmJzcDsgCQkJZGllKCJjcCAvYmluL3RydWUiKTs8L3NwYW4+PC9kaXY+
PGRpdj48c3Bhbj4mbmJzcDsgJm5ic3A7IAl9PC9zcGFuPjwvZGl2PjxkaXY+PGJyPjwvZGl2Pjxk
aXY+PHNwYW4+Jm5ic3A7ICZuYnNwOyAJLyogQmFzZWxpbmU6IGNvbmZpcm0gaXQgZXhlY3V0ZXMg
ZmluZSBiZWZvcmUgTGFuZGxvY2sgaXMgaW52b2x2ZWQuICovPC9zcGFuPjwvZGl2PjxkaXY+PHNw
YW4+Jm5ic3A7ICZuYnNwOyAJaWYgKHRyeV9leGVjdmUoInJlcHJvLWRpci9leGUiKSAhPSAwKSB7
PC9zcGFuPjwvZGl2PjxkaXY+PHNwYW4+Jm5ic3A7ICZuYnNwOyAJCWZwcmludGYoc3RkZXJyLCAi
YmFzZWxpbmUgZXhlY3ZlIGZhaWxlZCBldmVuIHdpdGhvdXQgTGFuZGxvY2sgLS0gIjwvc3Bhbj48
L2Rpdj48ZGl2PjxzcGFuPiZuYnNwOyAmbmJzcDsgCQkJCSJlbnZpcm9ubWVudCBwcm9ibGVtLCBu
b3QgYSBMYW5kbG9jayBpc3N1ZVxuIik7PC9zcGFuPjwvZGl2PjxkaXY+PHNwYW4+Jm5ic3A7ICZu
YnNwOyAJCXJldHVybiAxOzwvc3Bhbj48L2Rpdj48ZGl2PjxzcGFuPiZuYnNwOyAmbmJzcDsgCX08
L3NwYW4+PC9kaXY+PGRpdj48c3Bhbj4mbmJzcDsgJm5ic3A7IAlwcmludGYoIkJhc2VsaW5lIChu
byBMYW5kbG9jayk6IGV4ZWN2ZSBzdWNjZWVkZWQsIGFzIGV4cGVjdGVkLlxuIik7PC9zcGFuPjwv
ZGl2PjxkaXY+PGJyPjwvZGl2PjxkaXY+PHNwYW4+Jm5ic3A7ICZuYnNwOyAJLyogTWluaW1hbCBy
dWxlc2V0OiBFWEVDVVRFIG9ubHksIG1hdGNoaW5nIHRoZSBvZmZpY2lhbCBzZWxmdGVzdCdzPC9z
cGFuPjwvZGl2PjxkaXY+PHNwYW4+Jm5ic3A7ICZuYnNwOyAJICogcnVsZXNbMF0uYWNjZXNzID0g
TEFORExPQ0tfQUNDRVNTX0ZTX0VYRUNVVEUgZm9yIGxheW91dDEuZXhlY3V0ZS4gKi88L3NwYW4+
PC9kaXY+PGRpdj48c3Bhbj4mbmJzcDsgJm5ic3A7IAlzdHJ1Y3QgbGFuZGxvY2tfcnVsZXNldF9h
dHRyIHJ1bGVzZXRfYXR0ciA9IHs8L3NwYW4+PC9kaXY+PGRpdj48c3Bhbj4mbmJzcDsgJm5ic3A7
IAkJLmhhbmRsZWRfYWNjZXNzX2ZzID0gTEFORExPQ0tfQUNDRVNTX0ZTX0VYRUNVVEUsPC9zcGFu
PjwvZGl2PjxkaXY+PHNwYW4+Jm5ic3A7ICZuYnNwOyAJfTs8L3NwYW4+PC9kaXY+PGRpdj48c3Bh
bj4mbmJzcDsgJm5ic3A7IAlpbnQgcnVsZXNldF9mZCA9IGxhbmRsb2NrX2NyZWF0ZV9ydWxlc2V0
KCZhbXA7cnVsZXNldF9hdHRyLDwvc3Bhbj48L2Rpdj48ZGl2PjxzcGFuPiZuYnNwOyAmbmJzcDsg
CQkJCQkJICZuYnNwO3NpemVvZihydWxlc2V0X2F0dHIpLCAwKTs8L3NwYW4+PC9kaXY+PGRpdj48
c3Bhbj4mbmJzcDsgJm5ic3A7IAlpZiAocnVsZXNldF9mZCAmbHQ7IDApPC9zcGFuPjwvZGl2Pjxk
aXY+PHNwYW4+Jm5ic3A7ICZuYnNwOyAJCWRpZSgibGFuZGxvY2tfY3JlYXRlX3J1bGVzZXQiKTs8
L3NwYW4+PC9kaXY+PGRpdj48YnI+PC9kaXY+PGRpdj48c3Bhbj4mbmJzcDsgJm5ic3A7IAlpbnQg
cGFyZW50X2ZkID0gb3BlbigicmVwcm8tZGlyIiwgT19QQVRIKTs8L3NwYW4+PC9kaXY+PGRpdj48
c3Bhbj4mbmJzcDsgJm5ic3A7IAlpZiAocGFyZW50X2ZkICZsdDsgMCk8L3NwYW4+PC9kaXY+PGRp
dj48c3Bhbj4mbmJzcDsgJm5ic3A7IAkJZGllKCJvcGVuIHJlcHJvLWRpciBPX1BBVEgiKTs8L3Nw
YW4+PC9kaXY+PGRpdj48YnI+PC9kaXY+PGRpdj48c3Bhbj4mbmJzcDsgJm5ic3A7IAlzdHJ1Y3Qg
bGFuZGxvY2tfcGF0aF9iZW5lYXRoX2F0dHIgcGF0aF9iZW5lYXRoID0gezwvc3Bhbj48L2Rpdj48
ZGl2PjxzcGFuPiZuYnNwOyAmbmJzcDsgCQkuYWxsb3dlZF9hY2Nlc3MgPSBMQU5ETE9DS19BQ0NF
U1NfRlNfRVhFQ1VURSw8L3NwYW4+PC9kaXY+PGRpdj48c3Bhbj4mbmJzcDsgJm5ic3A7IAkJLnBh
cmVudF9mZCA9IHBhcmVudF9mZCw8L3NwYW4+PC9kaXY+PGRpdj48c3Bhbj4mbmJzcDsgJm5ic3A7
IAl9Ozwvc3Bhbj48L2Rpdj48ZGl2PjxzcGFuPiZuYnNwOyAmbmJzcDsgCWlmIChsYW5kbG9ja19h
ZGRfcnVsZShydWxlc2V0X2ZkLCBMQU5ETE9DS19SVUxFX1BBVEhfQkVORUFUSCw8L3NwYW4+PC9k
aXY+PGRpdj48c3Bhbj4mbmJzcDsgJm5ic3A7IAkJCSAmbmJzcDsgJm5ic3A7ICZuYnNwOyAmYW1w
O3BhdGhfYmVuZWF0aCwgMCkgIT0gMCk8L3NwYW4+PC9kaXY+PGRpdj48c3Bhbj4mbmJzcDsgJm5i
c3A7IAkJZGllKCJsYW5kbG9ja19hZGRfcnVsZSIpOzwvc3Bhbj48L2Rpdj48ZGl2PjxzcGFuPiZu
YnNwOyAmbmJzcDsgCWNsb3NlKHBhcmVudF9mZCk7PC9zcGFuPjwvZGl2PjxkaXY+PGJyPjwvZGl2
PjxkaXY+PHNwYW4+Jm5ic3A7ICZuYnNwOyAJaWYgKHByY3RsKFBSX1NFVF9OT19ORVdfUFJJVlMs
IDEsIDAsIDAsIDApICE9IDApPC9zcGFuPjwvZGl2PjxkaXY+PHNwYW4+Jm5ic3A7ICZuYnNwOyAJ
CWRpZSgicHJjdGwoUFJfU0VUX05PX05FV19QUklWUykiKTs8L3NwYW4+PC9kaXY+PGRpdj48YnI+
PC9kaXY+PGRpdj48c3Bhbj4mbmJzcDsgJm5ic3A7IAlpZiAobGFuZGxvY2tfcmVzdHJpY3Rfc2Vs
ZihydWxlc2V0X2ZkLCAwKSAhPSAwKTwvc3Bhbj48L2Rpdj48ZGl2PjxzcGFuPiZuYnNwOyAmbmJz
cDsgCQlkaWUoImxhbmRsb2NrX3Jlc3RyaWN0X3NlbGYiKTs8L3NwYW4+PC9kaXY+PGRpdj48c3Bh
bj4mbmJzcDsgJm5ic3A7IAljbG9zZShydWxlc2V0X2ZkKTs8L3NwYW4+PC9kaXY+PGRpdj48YnI+
PC9kaXY+PGRpdj48c3Bhbj4mbmJzcDsgJm5ic3A7IAlwcmludGYoIkxhbmRsb2NrIHJ1bGVzZXQg
aW5zdGFsbGVkOiBFWEVDVVRFLW9ubHksIG9uZSBQYXRoQmVuZWF0aCAiPC9zcGFuPjwvZGl2Pjxk
aXY+PHNwYW4+Jm5ic3A7ICZuYnNwOyAJICZuYnNwOyAmbmJzcDsgJm5ic3A7ICJydWxlIGFuY2hv
cmVkIG9uIHJlcHJvLWRpciAodGhlIHRhcmdldCBmaWxlJ3Mgb3duIHBhcmVudCkuXG4iKTs8L3Nw
YW4+PC9kaXY+PGRpdj48YnI+PC9kaXY+PGRpdj48c3Bhbj4mbmJzcDsgJm5ic3A7IAlpbnQgcmVz
dWx0ID0gdHJ5X2V4ZWN2ZSgicmVwcm8tZGlyL2V4ZSIpOzwvc3Bhbj48L2Rpdj48ZGl2PjxzcGFu
PiZuYnNwOyAmbmJzcDsgCWlmIChyZXN1bHQgPT0gMCkgezwvc3Bhbj48L2Rpdj48ZGl2PjxzcGFu
PiZuYnNwOyAmbmJzcDsgCQlwcmludGYoIlBBU1M6IGV4ZWN2ZSBzdWNjZWVkZWQsIGFzIHRoZSB1
cHN0cmVhbSBzZWxmdGVzdCAiPC9zcGFuPjwvZGl2PjxkaXY+PHNwYW4+Jm5ic3A7ICZuYnNwOyAJ
CSAmbmJzcDsgJm5ic3A7ICZuYnNwOyAiKGxheW91dDEuZXhlY3V0ZSwgZmlsZTFfczFkMiBjYXNl
KSBleHBlY3RzLlxuIik7PC9zcGFuPjwvZGl2PjxkaXY+PHNwYW4+Jm5ic3A7ICZuYnNwOyAJfSBl
bHNlIHs8L3NwYW4+PC9kaXY+PGRpdj48c3Bhbj4mbmJzcDsgJm5ic3A7IAkJcHJpbnRmKCJGQUlM
OiBleGVjdmUgd2FzIGRlbmllZCAoRUFDQ0VTKSBkZXNwaXRlIGFuICI8L3NwYW4+PC9kaXY+PGRp
dj48c3Bhbj4mbmJzcDsgJm5ic3A7IAkJICZuYnNwOyAmbmJzcDsgJm5ic3A7ICJleHBsaWNpdCwg
Y29ycmVjdGx5LWFuY2hvcmVkIFBhdGhCZW5lYXRoIHJ1bGUgIjwvc3Bhbj48L2Rpdj48ZGl2Pjxz
cGFuPiZuYnNwOyAmbmJzcDsgCQkgJm5ic3A7ICZuYnNwOyAmbmJzcDsgImdyYW50aW5nIExBTkRM
T0NLX0FDQ0VTU19GU19FWEVDVVRFIG9uIHRoZSBmaWxlJ3MgIjwvc3Bhbj48L2Rpdj48ZGl2Pjxz
cGFuPiZuYnNwOyAmbmJzcDsgCQkgJm5ic3A7ICZuYnNwOyAmbmJzcDsgIm93biBwYXJlbnQgZGly
ZWN0b3J5IC0tIHRoaXMgY29udHJhZGljdHMgIjwvc3Bhbj48L2Rpdj48ZGl2PjxzcGFuPiZuYnNw
OyAmbmJzcDsgCQkgJm5ic3A7ICZuYnNwOyAmbmJzcDsgInRvb2xzL3Rlc3Rpbmcvc2VsZnRlc3Rz
L2xhbmRsb2NrL2ZzX3Rlc3QuYydzICI8L3NwYW4+PC9kaXY+PGRpdj48c3Bhbj4mbmJzcDsgJm5i
c3A7IAkJICZuYnNwOyAmbmJzcDsgJm5ic3A7ICJURVNUX0ZfRk9SSyhsYXlvdXQxLCBleGVjdXRl
KSBleHBlY3RhdGlvbiBmb3IgdGhlICI8L3NwYW4+PC9kaXY+PGRpdj48c3Bhbj4mbmJzcDsgJm5i
c3A7IAkJICZuYnNwOyAmbmJzcDsgJm5ic3A7ICJmaWxlMV9zMWQyIGNhc2UuXG4iKTs8L3NwYW4+
PC9kaXY+PGRpdj48c3Bhbj4mbmJzcDsgJm5ic3A7IAl9PC9zcGFuPjwvZGl2PjxkaXY+PGJyPjwv
ZGl2PjxkaXY+PHNwYW4+Jm5ic3A7ICZuYnNwOyAJc3lzdGVtKCJybSAtcmYgcmVwcm8tZGlyIik7
PC9zcGFuPjwvZGl2PjxkaXY+PHNwYW4+Jm5ic3A7ICZuYnNwOyAJcmV0dXJuIHJlc3VsdDs8L3Nw
YW4+PC9kaXY+PGRpdj48c3Bhbj4mbmJzcDsgJm5ic3A7IH08L3NwYW4+PC9kaXY+PGRpdj48YnI+
PC9kaXY+PGRpdj48c3Bhbj5CdWlsZCBhbmQgcnVuOjwvc3Bhbj48L2Rpdj48ZGl2Pjxicj48L2Rp
dj48ZGl2PjxzcGFuPiZuYnNwOyAmbmJzcDsgJCBnY2MgLU8wIC1nIC1XYWxsIC1vIHJlcHJvIHJl
cHJvLmM8L3NwYW4+PC9kaXY+PGRpdj48c3Bhbj4mbmJzcDsgJm5ic3A7ICQgLi9yZXBybzwvc3Bh
bj48L2Rpdj48ZGl2PjxzcGFuPiZuYnNwOyAmbmJzcDsgTGFuZGxvY2sgQUJJIHZlcnNpb246IDk8
L3NwYW4+PC9kaXY+PGRpdj48c3Bhbj4mbmJzcDsgJm5ic3A7IEJhc2VsaW5lIChubyBMYW5kbG9j
ayk6IGV4ZWN2ZSBzdWNjZWVkZWQsIGFzIGV4cGVjdGVkLjwvc3Bhbj48L2Rpdj48ZGl2PjxzcGFu
PiZuYnNwOyAmbmJzcDsgTGFuZGxvY2sgcnVsZXNldCBpbnN0YWxsZWQ6IEVYRUNVVEUtb25seSwg
b25lIFBhdGhCZW5lYXRoIHJ1bGUgYW5jaG9yZWQgb24gcmVwcm8tZGlyICh0aGUgdGFyZ2V0IGZp
bGUncyBvd24gcGFyZW50KS48L3NwYW4+PC9kaXY+PGRpdj48c3Bhbj4mbmJzcDsgJm5ic3A7IGV4
ZWN2ZShyZXByby1kaXIvZXhlKSBmYWlsZWQ6IFBlcm1pc3Npb24gZGVuaWVkIChlcnJubyAxMyk8
L3NwYW4+PC9kaXY+PGRpdj48c3Bhbj4mbmJzcDsgJm5ic3A7IEZBSUw6IGV4ZWN2ZSB3YXMgZGVu
aWVkIChFQUNDRVMpIGRlc3BpdGUgYW4gZXhwbGljaXQsIGNvcnJlY3RseS1hbmNob3JlZCBQYXRo
QmVuZWF0aCBydWxlIGdyYW50aW5nIExBTkRMT0NLX0FDQ0VTU19GU19FWEVDVVRFIG9uIHRoZSBm
aWxlJ3Mgb3duIHBhcmVudCBkaXJlY3RvcnkgLS0gdGhpcyBjb250cmFkaWN0cyB0b29scy90ZXN0
aW5nL3NlbGZ0ZXN0cy9sYW5kbG9jay9mc190ZXN0LmMncyBURVNUX0ZfRk9SSyhsYXlvdXQxLCBl
eGVjdXRlKSBleHBlY3RhdGlvbiBmb3IgdGhlIGZpbGUxX3MxZDIgY2FzZS48L3NwYW4+PC9kaXY+
PGRpdj48YnI+PC9kaXY+PGRpdj48c3Bhbj5XaGF0IHdhcyBydWxlZCBvdXQgYmVmb3JlIGNvbmNs
dWRpbmcgdGhpcyBpcyBhIGtlcm5lbC1sZXZlbCBpc3N1ZTwvc3Bhbj48L2Rpdj48ZGl2PjxzcGFu
Pi0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0t
LS0tLS0tLS0tLS0tPC9zcGFuPjwvZGl2PjxkaXY+PGJyPjwvZGl2PjxkaXY+PHNwYW4+VGhpcyB3
YXMgaW52ZXN0aWdhdGVkIGV4dGVuc2l2ZWx5IGluIHRoZSBjb3Vyc2Ugb2YgZGVidWdnaW5nIGEg
cmVhbDwvc3Bhbj48L2Rpdj48ZGl2PjxzcGFuPmRvd25zdHJlYW0gcHJvamVjdCAoYSBSdXN0IGNv
ZGViYXNlIHVzaW5nIHRoZSBsYW5kbG9jayBjcmF0ZSAwLjQuNSkgdGhhdDwvc3Bhbj48L2Rpdj48
ZGl2PjxzcGFuPmhpdCB0aGlzIGV4YWN0IGRlbmlhbC4gQmVmb3JlIGNvbmNsdWRpbmcgaXQncyBh
IGtlcm5lbCBidWcgcmF0aGVyIHRoYW4gYTwvc3Bhbj48L2Rpdj48ZGl2PjxzcGFuPnVzZXJzcGFj
ZSBtaXN0YWtlLCB0aGUgZm9sbG93aW5nIHdlcmUgZWFjaCB0ZXN0ZWQgYW5kIHJ1bGVkIG91dCBh
cyB0aGU8L3NwYW4+PC9kaXY+PGRpdj48c3Bhbj5jYXVzZTo8L3NwYW4+PC9kaXY+PGRpdj48YnI+
PC9kaXY+PGRpdj48c3Bhbj4xLiBTRUxpbnV4OiB0aGlzIGhvc3QgcnVucyBTRUxpbnV4IEVuZm9y
Y2luZywgYnV0IHRoZSByZXByb2R1Y3Rpb248L3NwYW4+PC9kaXY+PGRpdj48c3Bhbj4mbmJzcDsg
Jm5ic3A7YWJvdmUgcnVucyBlbnRpcmVseSB1bmRlciB0aGUgaW50ZXJhY3RpdmUgc2hlbGwncyB1
bmNvbmZpbmVkX3Q8L3NwYW4+PC9kaXY+PGRpdj48c3Bhbj4mbmJzcDsgJm5ic3A7ZG9tYWluLCBh
bmQgdGhlIGlkZW50aWNhbCB0YXJnZXQgZmlsZSBleGVjdXRlcyBmaW5lIHZpYSBhIHBsYWluPC9z
cGFuPjwvZGl2PjxkaXY+PHNwYW4+Jm5ic3A7ICZuYnNwOyhub24tTGFuZGxvY2spIGV4ZWN2ZSgp
IGJlZm9yZWhhbmQgaW4gdGhlIHNhbWUgcHJvY2Vzcy4gT25seSBhZGRpbmc8L3NwYW4+PC9kaXY+
PGRpdj48c3Bhbj4mbmJzcDsgJm5ic3A7dGhlIExhbmRsb2NrIHJ1bGVzZXQgZmxpcHMgdGhlIHJl
c3VsdCB0byBFQUNDRVMuPC9zcGFuPjwvZGl2PjxkaXY+PGJyPjwvZGl2PjxkaXY+PHNwYW4+Mi4g
SVBFIChJbnRlZ3JpdHkgUG9saWN5IEVuZm9yY2VtZW50KTogZW5mb3JjZT0xIG9uIHRoaXMgaG9z
dCwgYnV0PC9zcGFuPjwvZGl2PjxkaXY+PHNwYW4+Jm5ic3A7ICZuYnNwOy9zeXMva2VybmVsL3Nl
Y3VyaXR5L2lwZS9wb2xpY2llcy8gaXMgZW1wdHkgKG5vIHBvbGljeSBsb2FkZWQpLCBhbmQ8L3Nw
YW4+PC9kaXY+PGRpdj48c3Bhbj4mbmJzcDsgJm5ic3A7bm8gSVBFLXJlbGF0ZWQgZGVuaWFsIGFw
cGVhcnMgaW4gdGhlIGF1ZGl0IGxvZyBhcm91bmQgdGhlIGZhaWx1cmUuIEE8L3NwYW4+PC9kaXY+
PGRpdj48c3Bhbj4mbmJzcDsgJm5ic3A7cGxhaW4gZXhlY3ZlKCkgb2YgdGhlIHNhbWUgZmlsZSB3
aXRoIG5vIExhbmRsb2NrIGRvbWFpbiBhY3RpdmU8L3NwYW4+PC9kaXY+PGRpdj48c3Bhbj4mbmJz
cDsgJm5ic3A7c3VjY2VlZHMsIHdoaWNoIHdvdWxkIG5vdCBiZSB0aGUgY2FzZSBpZiBJUEUgd2Vy
ZSB1bmNvbmRpdGlvbmFsbHk8L3NwYW4+PC9kaXY+PGRpdj48c3Bhbj4mbmJzcDsgJm5ic3A7ZGVu
eWluZyB0aGlzIGZpbGUuPC9zcGFuPjwvZGl2PjxkaXY+PGJyPjwvZGl2PjxkaXY+PHNwYW4+My4g
S2VybmVsIGxvY2tkb3duIG1vZGU6IGFjdGl2ZSBhdCAiaW50ZWdyaXR5IiBsZXZlbCBvbiB0aGlz
IGhvc3Q8L3NwYW4+PC9kaXY+PGRpdj48c3Bhbj4mbmJzcDsgJm5ic3A7KEZlZG9yYSBlbmFibGVz
IHRoaXMgYXV0b21hdGljYWxseSB1bmRlciBTZWN1cmUgQm9vdCksIGJ1dCBsb2NrZG93bidzPC9z
cGFuPjwvZGl2PjxkaXY+PHNwYW4+Jm5ic3A7ICZuYnNwO2RvY3VtZW50ZWQgcmVzdHJpY3Rpb25z
IChtb2R1bGUgc2lnbmluZywgL2Rldi9tZW0sIGhpYmVybmF0aW9uLDwvc3Bhbj48L2Rpdj48ZGl2
PjxzcGFuPiZuYnNwOyAmbmJzcDtrZXhlYywgZGVidWdmcywgZXRjLikgZ292ZXJuIGtlcm5lbC1p
bWFnZS1pbnRlZ3JpdHkgb3BlcmF0aW9ucywgbm90PC9zcGFuPjwvZGl2PjxkaXY+PHNwYW4+Jm5i
c3A7ICZuYnNwO29yZGluYXJ5IHVucHJpdmlsZWdlZCBMU00gcG9saWN5IGRlY2lzaW9ucyBsaWtl
IExhbmRsb2NrJ3Mgb3duPC9zcGFuPjwvZGl2PjxkaXY+PHNwYW4+Jm5ic3A7ICZuYnNwO2ZpbGVz
eXN0ZW0gY2hlY2tzLCBhbmQgbm8gZG9jdW1lbnRlZCBpbnRlcmFjdGlvbiBiZXR3ZWVuIHRoZSB0
d28gd2FzPC9zcGFuPjwvZGl2PjxkaXY+PHNwYW4+Jm5ic3A7ICZuYnNwO2ZvdW5kLjwvc3Bhbj48
L2Rpdj48ZGl2Pjxicj48L2Rpdj48ZGl2PjxzcGFuPjQuIHRtcGZzIHZzLiBhIHJlYWwgb24tZGlz
ayBmaWxlc3lzdGVtOiB0aGUgZGVuaWFsIHJlcHJvZHVjZXM8L3NwYW4+PC9kaXY+PGRpdj48c3Bh
bj4mbmJzcDsgJm5ic3A7aWRlbnRpY2FsbHkgd2hldGhlciB0aGUgdGFyZ2V0IGRpcmVjdG9yeSBp
cyBvbiB0bXBmcyAoL3RtcCkgb3IgYTwvc3Bhbj48L2Rpdj48ZGl2PjxzcGFuPiZuYnNwOyAmbmJz
cDtyZWFsIG9uLWRpc2sgYnRyZnMgZmlsZXN5c3RlbSAodGhlIHJvb3QgZmlsZXN5c3RlbSkuPC9z
cGFuPjwvZGl2PjxkaXY+PGJyPjwvZGl2PjxkaXY+PHNwYW4+NS4gZmQtYmFzZWQgKGV4ZWN2ZWF0
K0FUX0VNUFRZX1BBVEgpIHZzLiBwYXRoLWJhc2VkIGV4ZWN2ZSgpOiBib3RoPC9zcGFuPjwvZGl2
PjxkaXY+PHNwYW4+Jm5ic3A7ICZuYnNwO2ZhaWwgaWRlbnRpY2FsbHk7IHRoaXMgaXMgbm90IHNw
ZWNpZmljIHRvIGV4ZWN1dGluZyB2aWEgYW48L3NwYW4+PC9kaXY+PGRpdj48c3Bhbj4mbmJzcDsg
Jm5ic3A7YWxyZWFkeS1vcGVuIGZpbGUgZGVzY3JpcHRvci48L3NwYW4+PC9kaXY+PGRpdj48YnI+
PC9kaXY+PGRpdj48c3Bhbj42LiBEaXJlY3QgY2hpbGQgdnMuIG5lc3RlZCBzdWJkaXJlY3Rvcnk6
IGEgZmlsZSBuZXN0ZWQgb25lIGxldmVsIGRlZXBlcjwvc3Bhbj48L2Rpdj48ZGl2PjxzcGFuPiZu
YnNwOyAmbmJzcDt0aGFuIHRoZSBhbmNob3JlZCBydWxlIGZhaWxzIGlkZW50aWNhbGx5IHRvIGEg
ZmlsZSBkaXJlY3RseSBpbiB0aGU8L3NwYW4+PC9kaXY+PGRpdj48c3Bhbj4mbmJzcDsgJm5ic3A7
YW5jaG9yZWQgZGlyZWN0b3J5Ljwvc3Bhbj48L2Rpdj48ZGl2Pjxicj48L2Rpdj48ZGl2PjxzcGFu
PjcuIE9fUEFUSCB2cy4gcGxhaW4gb3BlbigpIGZvciB0aGUgcnVsZSdzIGFuY2hvciBmZDogbm8g
ZGlmZmVyZW5jZTwvc3Bhbj48L2Rpdj48ZGl2PjxzcGFuPiZuYnNwOyAmbmJzcDsodGhlIGxhbmRs
b2NrIFJ1c3QgY3JhdGUncyBvd24gZG9jdW1lbnRhdGlvbiB3YXJucyBwbGFpbiBGaWxlIG9wZW5z
PC9zcGFuPjwvZGl2PjxkaXY+PHNwYW4+Jm5ic3A7ICZuYnNwOyJtYXkgbGVhZCB0byB1bmV4cGVj
dGVkIGVycm9ycywiIGJ1dCBleHBsaWNpdGx5IHRlc3RpbmcgT19QQVRIPC9zcGFuPjwvZGl2Pjxk
aXY+PHNwYW4+Jm5ic3A7ICZuYnNwO3Byb2R1Y2VkIHRoZSBpZGVudGljYWwgZGVuaWFsKS48L3Nw
YW4+PC9kaXY+PGRpdj48YnI+PC9kaXY+PGRpdj48c3Bhbj44LiBSdWxlc2V0IHJpZ2h0cyBicmVh
ZHRoOiB0ZXN0ZWQgd2l0aCBoYW5kbGVkX2FjY2Vzc19mcyBhcyBFWEVDVVRFLW9ubHk8L3NwYW4+
PC9kaXY+PGRpdj48c3Bhbj4mbmJzcDsgJm5ic3A7YXMgdGhlIGZ1bGwgVjMtZXJhIDE1LXJpZ2h0
IHNldCwgYW5kIHdpdGggYW4gYWRkaXRpb25hbCBleHBsaWNpdDwvc3Bhbj48L2Rpdj48ZGl2Pjxz
cGFuPiZuYnNwOyAmbmJzcDtmaWxlLWFuY2hvcmVkIHJ1bGUgKGNvcnJlY3RseSBzY29wZWQgdG8g
ZmlsZS12YWxpZCByaWdodHMpIGxheWVyZWQ8L3NwYW4+PC9kaXY+PGRpdj48c3Bhbj4mbmJzcDsg
Jm5ic3A7YWxvbmdzaWRlIHRoZSBkaXJlY3RvcnkgcnVsZS4gQWxsIGlkZW50aWNhbC48L3NwYW4+
PC9kaXY+PGRpdj48YnI+PC9kaXY+PGRpdj48c3Bhbj45LiBsYW5kbG9ja19ydWxlc2V0X2F0dHIg
c3RydWN0IHNpemU6IHRlc3RlZCB3aXRoIHRoZSBzdHJ1Y3QgcGFzc2VkIGF0PC9zcGFuPjwvZGl2
PjxkaXY+PHNwYW4+Jm5ic3A7ICZuYnNwOzI0LCAzMiwgNDgsIGFuZCA2NCBieXRlcyAocGFkZGVk
IHdpdGggemVyb2VkIHRyYWlsaW5nIGZpZWxkcywgaW4gY2FzZTwvc3Bhbj48L2Rpdj48ZGl2Pjxz
cGFuPiZuYnNwOyAmbmJzcDtvZiBhbiBleHRlbnNpYmxlLXN0cnVjdCB6ZXJvLWV4dGVuc2lvbiBn
YXAgZm9yIGZpZWxkcyBpbnRyb2R1Y2VkIGF0PC9zcGFuPjwvZGl2PjxkaXY+PHNwYW4+Jm5ic3A7
ICZuYnNwO0FCSSA4LzksIGUuZy4gdGhlIHF1aWV0X2FjY2Vzc19mcy9xdWlldF9hY2Nlc3NfbmV0
L3F1aWV0X3Njb3BlZDwvc3Bhbj48L2Rpdj48ZGl2PjxzcGFuPiZuYnNwOyAmbmJzcDtmaWVsZHMg
YWRkZWQgYXJvdW5kIEFCSSA3LTkpLiBObyBkaWZmZXJlbmNlOyB0aGUgcmVwcm9kdWN0aW9uPC9z
cGFuPjwvZGl2PjxkaXY+PHNwYW4+Jm5ic3A7ICZuYnNwO2F0dGFjaGVkIHVzZXMgc2l6ZW9mKHJ1
bGVzZXRfYXR0cikgYWdhaW5zdCB0aGUgcmVhbCBzeXN0ZW0gaGVhZGVyLDwvc3Bhbj48L2Rpdj48
ZGl2PjxzcGFuPiZuYnNwOyAmbmJzcDttYXRjaGluZyB1cHN0cmVhbSBzZWxmdGVzdCBjb252ZW50
aW9uIGV4YWN0bHkuPC9zcGFuPjwvZGl2PjxkaXY+PGJyPjwvZGl2PjxkaXY+PHNwYW4+MTAuIFB1
Ymxpc2hlZCBlcnJhdGE6IGNoZWNrZWQgYWxsIHRocmVlIGN1cnJlbnRseS1kb2N1bWVudGVkIGVu
dHJpZXM8L3NwYW4+PC9kaXY+PGRpdj48c3Bhbj4mbmJzcDsgJm5ic3A7IGluIHNlY3VyaXR5L2xh
bmRsb2NrL2VycmF0YS8gKGRpc2Nvbm5lY3RlZC1kaXJlY3RvcnkgcmVuYW1lPC9zcGFuPjwvZGl2
PjxkaXY+PHNwYW4+Jm5ic3A7ICZuYnNwOyB3aWRlbmluZywgVENQIHNvY2tldCBwcm90b2NvbCBt
aXNjbGFzc2lmaWNhdGlvbiwgdGhyZWFkIHNpZ25hbDwvc3Bhbj48L2Rpdj48ZGl2PjxzcGFuPiZu
YnNwOyAmbmJzcDsgc2NvcGluZykuIE5vbmUgbWF0Y2ggdGhpcyBzeW1wdG9tLjwvc3Bhbj48L2Rp
dj48ZGl2Pjxicj48L2Rpdj48ZGl2PjxzcGFuPjExLiBEaXJlY3QgcmVhZCBvZiBzZWN1cml0eS9s
YW5kbG9jay9mcy5jIG9uIHRvcnZhbGRzL2xpbnV4IG1hc3Rlcjo8L3NwYW4+PC9kaXY+PGRpdj48
c3Bhbj4mbmJzcDsgJm5ic3A7IHRoZSBpc19hY2Nlc3NfdG9fcGF0aHNfYWxsb3dlZCgpL2N1cnJl
bnRfY2hlY2tfYWNjZXNzX3BhdGgoKS88L3NwYW4+PC9kaXY+PGRpdj48c3Bhbj4mbmJzcDsgJm5i
c3A7IGhvb2tfZmlsZV9vcGVuKCkgaGllcmFyY2h5LXdhbGsgbG9naWMgYXBwZWFycyBjb3JyZWN0
IGZvciB0aGlzPC9zcGFuPjwvZGl2PjxkaXY+PHNwYW4+Jm5ic3A7ICZuYnNwOyBzaW1wbGUgY2Fz
ZSAod2FsayBzdGFydHMgYXQgdGhlIHRhcmdldCBmaWxlJ3Mgb3duIGRlbnRyeSwgY2hlY2tzPC9z
cGFuPjwvZGl2PjxkaXY+PHNwYW4+Jm5ic3A7ICZuYnNwOyBmaW5kX3J1bGUoKSBhdCBlYWNoIGxl
dmVsIHdoaWxlIHdhbGtpbmcgdXAgdmlhIGRnZXRfcGFyZW50KCksIGFuZDwvc3Bhbj48L2Rpdj48
ZGl2PjxzcGFuPiZuYnNwOyAmbmJzcDsgb3VyIGFuY2hvciBpcyBleGFjdGx5IG9uZSBsZXZlbCB1
cCkuIE5vIG9idmlvdXMgbG9naWMgZGVmZWN0IHdhczwvc3Bhbj48L2Rpdj48ZGl2PjxzcGFuPiZu
YnNwOyAmbmJzcDsgZm91bmQgYnkgaW5zcGVjdGlvbiwgd2hpY2ggaXMgcGFydCBvZiB3aHkgdGhp
cyBpcyBiZWluZyByZXBvcnRlZDwvc3Bhbj48L2Rpdj48ZGl2PjxzcGFuPiZuYnNwOyAmbmJzcDsg
cmF0aGVyIHRoYW4gZml4ZWQgZG93bnN0cmVhbS48L3NwYW4+PC9kaXY+PGRpdj48YnI+PC9kaXY+
PGRpdj48c3Bhbj5HaXZlbiAoMTEpLCBpZiB0aGUgbWFzdGVyLWJyYW5jaCBsb2dpYyBpcyBjb3Jy
ZWN0LCB0aGlzIG1heSBhbHJlYWR5IGJlPC9zcGFuPjwvZGl2PjxkaXY+PHNwYW4+Zml4ZWQgaW4g
YSB0cmVlIG5ld2VyIHRoYW4gNy4xLjMsIG9yIHRoZSByZWdyZXNzaW9uIHdpbmRvdyBtYXkgYmU8
L3NwYW4+PC9kaXY+PGRpdj48c3Bhbj5uYXJyb3cgYnV0IGFzIG9mIHRoaXMgZXhhY3Qga2VybmVs
LCB0aGUgZGlzY3JlcGFuY3kgYWdhaW5zdCB0aGU8L3NwYW4+PC9kaXY+PGRpdj48c3Bhbj5zZWxm
dGVzdCdzIG93biBkb2N1bWVudGVkIGV4cGVjdGF0aW9uIGlzIHJlYWwgYW5kIHJlcHJvZHVjaWJs
ZS48L3NwYW4+PC9kaXY+PGRpdj48YnI+PC9kaXY+PGRpdj48c3Bhbj5JbXBhY3Q8L3NwYW4+PC9k
aXY+PGRpdj48c3Bhbj4tLS0tLS08L3NwYW4+PC9kaXY+PGRpdj48YnI+PC9kaXY+PGRpdj48c3Bh
bj5UaGlzIGFmZmVjdHMgYW55IHVucHJpdmlsZWdlZCAob3IgcHJpdmlsZWdlZCwgc2VsZi1yZXN0
cmljdGluZykgcHJvY2Vzczwvc3Bhbj48L2Rpdj48ZGl2PjxzcGFuPnRoYXQgaW5zdGFsbHMgYSBt
aW5pbWFsIExhbmRsb2NrIGRvbWFpbiBhbmQgdGhlbiB0cmllcyB0byBleGVjdXRlIGEgZmlsZTwv
c3Bhbj48L2Rpdj48ZGl2PjxzcGFuPmNvdmVyZWQgYnkgYSBkaXJlY3RvcnktYW5jaG9yZWQgcnVs
ZSB3aGljaCBpcyBhIGNvbW1vbiBMYW5kbG9jayB1c2FnZTwvc3Bhbj48L2Rpdj48ZGl2PjxzcGFu
PnBhdHRlcm4gKG1hdGNoaW5nIHRoZSBrZXJuZWwncyBvd24gc2VsZnRlc3QpLjwvc3Bhbj48L2Rp
dj48ZGl2PjxzcGFuPkRvd25zdHJlYW0sIGl0IHNpbGVudGx5IGJyZWFrcyBhIHNlY3VyaXR5LWhh
cmRlbmluZyBjb2RlIHBhdGg8L3NwYW4+PC9kaXY+PGRpdj48c3Bhbj4oTGFuZGxvY2stYmFzZWQg
ZmlsZXN5c3RlbSBjb25maW5lbWVudCBmb3IgYSBwcml2aWxlZ2VkIHByb2Nlc3MgdHJlZSk8L3Nw
YW4+PC9kaXY+PGRpdj48c3Bhbj53aXRoIG5vIGRpYWdub3N0aWMgYmV5b25kIGEgZ2VuZXJpYyBF
QUNDRVMsIHNpbmNlIHRoZSBwcm9jZXNzIGF0dGVtcHRpbmc8L3NwYW4+PC9kaXY+PGRpdj48c3Bh
bj50aGUgZXhlYyBoYXMgYWxyZWFkeSBkcm9wcGVkIHByaXZpbGVnZXMgYW5kIGNhbm5vdCBtZWFu
aW5nZnVsbHkgcmVwb3J0PC9zcGFuPjwvZGl2PjxkaXY+PHNwYW4+dGhlIGZhaWx1cmUgYmFjayB0
byBhIHBhcmVudCB0aHJvdWdoIGFkdmFuY2VkIG1lYW5zLjwvc3Bhbj48L2Rpdj48ZGl2Pjxicj48
L2Rpdj48ZGl2PjxzcGFuPlJlcXVlc3Q8L3NwYW4+PC9kaXY+PGRpdj48c3Bhbj4tLS0tLS0tPC9z
cGFuPjwvZGl2PjxkaXY+PGJyPjwvZGl2PjxkaXY+PHNwYW4+Q291bGQgeW91IGNvbmZpcm0gd2hl
dGhlciB0aGlzIGlzIGEga25vd24vYWxyZWFkeS1maXhlZCBpc3N1ZSwgYW5kIGlmPC9zcGFuPjwv
ZGl2PjxkaXY+PHNwYW4+bm90LCB3aGV0aGVyIHRoZSBhdHRhY2hlZCByZXByb2R1Y3Rpb24gaXMg
c3VmZmljaWVudCB0byB0cmFjayBkb3duIHRoZTwvc3Bhbj48L2Rpdj48ZGl2PjxzcGFuPnJlZ3Jl
c3Npb24/IExldCBtZSBrbm93IGlmIHlvdSdkIGxpa2UgbWUgdGVzdCBhIHBhdGNoIG9yIHByb3Zp
ZGUgbW9yZTwvc3Bhbj48L2Rpdj48ZGl2PjxzcGFuPmluc3RydW1lbnRhdGlvbiBmcm9tIHRoaXMg
ZXhhY3Qga2VybmVsIGJ1aWxkIGlmIHVzZWZ1bC48L3NwYW4+PC9kaXY+PGRpdj48YnI+PC9kaXY+
PGRpdj48c3Bhbj5BdHRhY2htZW50czwvc3Bhbj48L2Rpdj48ZGl2PjxzcGFuPi0tLS0tLS0tLS0t
PC9zcGFuPjwvZGl2PjxkaXY+PGJyPjwvZGl2PjxkaXY+PHNwYW4+LSByZXByby5jIC0gbWluaW1h
bCBzdGFuZGFsb25lIHJlcHJvZHVjdGlvbiAoYWxzbyBpbmxpbmVkIGFib3ZlKTwvc3Bhbj48L2Rp
dj48ZGl2PjxzcGFuPi0gb2ZmaWNpYWwtc2VsZnRlc3Qtb3V0cHV0LmxvZyAtIGZ1bGwgcmF3IFRB
UCBvdXRwdXQgZnJvbSBydW5uaW5nIHRoZTwvc3Bhbj48L2Rpdj48c3Bhbj4mbmJzcDsgdW5tb2Rp
ZmllZCB2Ny4xLjMgZnNfdGVzdCAtZiBsYXlvdXQxIC10IGV4ZWN1dGUgYWdhaW5zdCB0aGlzIGtl
cm5lbDwvc3Bhbj48YnI+PC9kaXY+CjxkaXYgc3R5bGU9ImZvbnQtZmFtaWx5OiBBcmlhbCwgc2Fu
cy1zZXJpZjsgZm9udC1zaXplOiAxNHB4OyIgY2xhc3M9InByb3Rvbm1haWxfc2lnbmF0dXJlX2Js
b2NrIHByb3Rvbm1haWxfc2lnbmF0dXJlX2Jsb2NrLWVtcHR5Ij4KICAgIDxkaXYgY2xhc3M9InBy
b3Rvbm1haWxfc2lnbmF0dXJlX2Jsb2NrLXVzZXIgcHJvdG9ubWFpbF9zaWduYXR1cmVfYmxvY2st
ZW1wdHkiPgogICAgICAgIAogICAgICAgICAgICA8L2Rpdj4KICAgIAogICAgICAgICAgICA8ZGl2
IGNsYXNzPSJwcm90b25tYWlsX3NpZ25hdHVyZV9ibG9jay1wcm90b24gcHJvdG9ubWFpbF9zaWdu
YXR1cmVfYmxvY2stZW1wdHkiPgogICAgICAgIAogICAgICAgICAgICA8L2Rpdj4KPC9kaXY+Cg==
-----------------------101ee20b184380757c033b7287959fa5--
-----------------------cbd988f438d6f82217af6e33ea3165a6--
-----------------------a13646fe735a870407e4d755e7eb20de
Content-Type: text/x-csrc; filename="repro.c"; name="repro.c"
Content-Transfer-Encoding: base64
Content-Disposition: attachment; filename="repro.c"; name="repro.c"

LyoKICogTWluaW1hbCBzdGFuZGFsb25lIHJlcHJvZHVjdGlvbiBvZiBhIExhbmRsb2NrIEVYRUNV
VEUtcmlnaHQgZGVuaWFsIHRoYXQKICogY29udHJhZGljdHMgdGhlIHVwc3RyZWFtIGtlcm5lbCdz
IG93biBzZWxmdGVzdCBleHBlY3RhdGlvbi4KICoKICogVGhpcyBtaXJyb3JzIHRvb2xzL3Rlc3Rp
bmcvc2VsZnRlc3RzL2xhbmRsb2NrL2ZzX3Rlc3QuYydzCiAqIFRFU1RfRl9GT1JLKGxheW91dDEs
IGV4ZWN1dGUpIC0tIHNwZWNpZmljYWxseSB0aGUgZmlsZTFfczFkMiBjYXNlOiBhCiAqIFBhdGhC
ZW5lYXRoIHJ1bGUgZ3JhbnRpbmcgb25seSBMQU5ETE9DS19BQ0NFU1NfRlNfRVhFQ1VURSwgYW5j
aG9yZWQgb24gYQogKiBkaXJlY3RvcnksIGlzIGV4cGVjdGVkIHRvIHBlcm1pdCBleGVjdmUoKSBv
ZiBhIGZpbGUgZGlyZWN0bHkgaW5zaWRlIHRoYXQKICogZGlyZWN0b3J5ICh1cHN0cmVhbSBhc3Nl
cnRzIHRlc3RfZXhlY3V0ZShfbWV0YWRhdGEsIDAsIGZpbGUxX3MxZDIpLCBpLmUuCiAqICJubyBl
cnJvciIpLiBPbiB0aGlzIGtlcm5lbCBpdCBpcyBkZW5pZWQgd2l0aCBFQUNDRVMgaW5zdGVhZC4K
ICoKICogTm8gcm9vdC9DQVBfU1lTX0FETUlOIHJlcXVpcmVkIC0tIExhbmRsb2NrIGlzIGRlc2ln
bmVkIGZvciB1bnByaXZpbGVnZWQKICogdXNlLCBhbmQgdGhpcyByZXByb2R1Y2VzIHRoZSBzYW1l
IHdheSBhcyBhbiBvcmRpbmFyeSB1c2VyLgogKgogKiBCdWlsZDogICBnY2MgLU8wIC1nIC1XYWxs
IC1vIHJlcHJvIHJlcHJvLmMKICogUnVuOiAgICAgLi9yZXBybwogKgogKiBPYnNlcnZlZCBvbjog
TGludXggNy4xLjMtMjAwLmZjNDQueDg2XzY0IChGZWRvcmEgNDQgV29ya3N0YXRpb24pLAogKiBM
YW5kbG9jayBBQkkgdmVyc2lvbiA5IChwZXIgbGFuZGxvY2tfY3JlYXRlX3J1bGVzZXQoTlVMTCwg
MCwKICogTEFORExPQ0tfQ1JFQVRFX1JVTEVTRVRfVkVSU0lPTikpLgogKi8KCiNkZWZpbmUgX0dO
VV9TT1VSQ0UKI2luY2x1ZGUgPGVycm5vLmg+CiNpbmNsdWRlIDxmY250bC5oPgojaW5jbHVkZSA8
bGludXgvbGFuZGxvY2suaD4KI2luY2x1ZGUgPHN0ZGlvLmg+CiNpbmNsdWRlIDxzdGRsaWIuaD4K
I2luY2x1ZGUgPHN0cmluZy5oPgojaW5jbHVkZSA8c3lzL3ByY3RsLmg+CiNpbmNsdWRlIDxzeXMv
c3RhdC5oPgojaW5jbHVkZSA8c3lzL3N5c2NhbGwuaD4KI2luY2x1ZGUgPHN5cy93YWl0Lmg+CiNp
bmNsdWRlIDx1bmlzdGQuaD4KCnN0YXRpYyBpbnQgbGFuZGxvY2tfY3JlYXRlX3J1bGVzZXQoY29u
c3Qgc3RydWN0IGxhbmRsb2NrX3J1bGVzZXRfYXR0ciAqYXR0ciwKCQkJCSAgICBzaXplX3Qgc2l6
ZSwgX191MzIgZmxhZ3MpCnsKCXJldHVybiBzeXNjYWxsKFNZU19sYW5kbG9ja19jcmVhdGVfcnVs
ZXNldCwgYXR0ciwgc2l6ZSwgZmxhZ3MpOwp9CgpzdGF0aWMgaW50IGxhbmRsb2NrX2FkZF9ydWxl
KGludCBydWxlc2V0X2ZkLCBlbnVtIGxhbmRsb2NrX3J1bGVfdHlwZSB0eXBlLAoJCQkgICAgICBj
b25zdCB2b2lkICphdHRyLCBfX3UzMiBmbGFncykKewoJcmV0dXJuIHN5c2NhbGwoU1lTX2xhbmRs
b2NrX2FkZF9ydWxlLCBydWxlc2V0X2ZkLCB0eXBlLCBhdHRyLCBmbGFncyk7Cn0KCnN0YXRpYyBp
bnQgbGFuZGxvY2tfcmVzdHJpY3Rfc2VsZihpbnQgcnVsZXNldF9mZCwgX191MzIgZmxhZ3MpCnsK
CXJldHVybiBzeXNjYWxsKFNZU19sYW5kbG9ja19yZXN0cmljdF9zZWxmLCBydWxlc2V0X2ZkLCBm
bGFncyk7Cn0KCnN0YXRpYyB2b2lkIGRpZShjb25zdCBjaGFyICp3aGF0KQp7CglmcHJpbnRmKHN0
ZGVyciwgIiVzOiAlc1xuIiwgd2hhdCwgc3RyZXJyb3IoZXJybm8pKTsKCWV4aXQoMSk7Cn0KCi8q
IFJ1bnMgYHBhdGhgIHZpYSBhIGZyZXNoIGV4ZWN2ZSgpIGluIGEgY2hpbGQsIHByaW50cyBhbmQg
cmV0dXJucyBpdHMgcmVzdWx0LiAqLwpzdGF0aWMgaW50IHRyeV9leGVjdmUoY29uc3QgY2hhciAq
cGF0aCkKewoJcGlkX3QgcGlkID0gZm9yaygpOwoJaWYgKHBpZCA8IDApCgkJZGllKCJmb3JrIik7
CglpZiAocGlkID09IDApIHsKCQljaGFyICpjb25zdCBhcmd2W10gPSB7IChjaGFyICopcGF0aCwg
TlVMTCB9OwoJCWV4ZWN2ZShwYXRoLCBhcmd2LCBOVUxMKTsKCQkvKiBPbmx5IHJlYWNoZWQgb24g
ZmFpbHVyZS4gKi8KCQlmcHJpbnRmKHN0ZGVyciwgImV4ZWN2ZSglcykgZmFpbGVkOiAlcyAoZXJy
bm8gJWQpXG4iLCBwYXRoLAoJCQlzdHJlcnJvcihlcnJubyksIGVycm5vKTsKCQlfZXhpdCgxKTsK
CX0KCWludCBzdGF0dXM7Cgl3YWl0cGlkKHBpZCwgJnN0YXR1cywgMCk7CglpZiAoV0lGRVhJVEVE
KHN0YXR1cykgJiYgV0VYSVRTVEFUVVMoc3RhdHVzKSA9PSAwKQoJCXJldHVybiAwOwoJcmV0dXJu
IDE7Cn0KCmludCBtYWluKHZvaWQpCnsKCWludCBhYmkgPSBsYW5kbG9ja19jcmVhdGVfcnVsZXNl
dChOVUxMLCAwLAoJCQkJCSAgIExBTkRMT0NLX0NSRUFURV9SVUxFU0VUX1ZFUlNJT04pOwoJcHJp
bnRmKCJMYW5kbG9jayBBQkkgdmVyc2lvbjogJWRcbiIsIGFiaSk7CglpZiAoYWJpIDwgMCkKCQlk
aWUoImxhbmRsb2NrX2NyZWF0ZV9ydWxlc2V0KFZFUlNJT04pIik7CgoJLyogQnVpbGQgdG1wL2Rp
ci9leGUsIG1hdGNoaW5nIGxheW91dDEncyBkaXJfczFkMi9maWxlMV9zMWQyIHNoYXBlOgoJICog
YSBydWxlIGFuY2hvcmVkIG9uIHRoZSBwYXJlbnQgZGlyZWN0b3J5LCB0YXJnZXQgZmlsZSBkaXJl
Y3RseQoJICogaW5zaWRlIGl0ICh6ZXJvIGxldmVscyBvZiBleHRyYSBuZXN0aW5nKS4gKi8KCWlm
IChta2RpcigicmVwcm8tZGlyIiwgMDcwMCkgPCAwICYmIGVycm5vICE9IEVFWElTVCkKCQlkaWUo
Im1rZGlyIHJlcHJvLWRpciIpOwoKCS8qIENvcHkgL2Jpbi90cnVlIGluIGFzIG91ciB0YXJnZXQg
ZXhlY3V0YWJsZS4gKi8KCXsKCQljaGFyIGNtZFsyNTZdOwoJCXNucHJpbnRmKGNtZCwgc2l6ZW9m
KGNtZCksCgkJCSAiY3AgL2Jpbi90cnVlIHJlcHJvLWRpci9leGUgJiYgY2htb2QgNzU1IHJlcHJv
LWRpci9leGUiKTsKCQlpZiAoc3lzdGVtKGNtZCkgIT0gMCkKCQkJZGllKCJjcCAvYmluL3RydWUi
KTsKCX0KCgkvKiBCYXNlbGluZTogY29uZmlybSBpdCBleGVjdXRlcyBmaW5lIGJlZm9yZSBMYW5k
bG9jayBpcyBpbnZvbHZlZC4gKi8KCWlmICh0cnlfZXhlY3ZlKCJyZXByby1kaXIvZXhlIikgIT0g
MCkgewoJCWZwcmludGYoc3RkZXJyLCAiYmFzZWxpbmUgZXhlY3ZlIGZhaWxlZCBldmVuIHdpdGhv
dXQgTGFuZGxvY2sgLS0gIgoJCQkJImVudmlyb25tZW50IHByb2JsZW0sIG5vdCBhIExhbmRsb2Nr
IGlzc3VlXG4iKTsKCQlyZXR1cm4gMTsKCX0KCXByaW50ZigiQmFzZWxpbmUgKG5vIExhbmRsb2Nr
KTogZXhlY3ZlIHN1Y2NlZWRlZCwgYXMgZXhwZWN0ZWQuXG4iKTsKCgkvKiBNaW5pbWFsIHJ1bGVz
ZXQ6IEVYRUNVVEUgb25seSwgbWF0Y2hpbmcgdGhlIG9mZmljaWFsIHNlbGZ0ZXN0J3MKCSAqIHJ1
bGVzWzBdLmFjY2VzcyA9IExBTkRMT0NLX0FDQ0VTU19GU19FWEVDVVRFIGZvciBsYXlvdXQxLmV4
ZWN1dGUuICovCglzdHJ1Y3QgbGFuZGxvY2tfcnVsZXNldF9hdHRyIHJ1bGVzZXRfYXR0ciA9IHsK
CQkuaGFuZGxlZF9hY2Nlc3NfZnMgPSBMQU5ETE9DS19BQ0NFU1NfRlNfRVhFQ1VURSwKCX07Cglp
bnQgcnVsZXNldF9mZCA9IGxhbmRsb2NrX2NyZWF0ZV9ydWxlc2V0KCZydWxlc2V0X2F0dHIsCgkJ
CQkJCSAgc2l6ZW9mKHJ1bGVzZXRfYXR0ciksIDApOwoJaWYgKHJ1bGVzZXRfZmQgPCAwKQoJCWRp
ZSgibGFuZGxvY2tfY3JlYXRlX3J1bGVzZXQiKTsKCglpbnQgcGFyZW50X2ZkID0gb3BlbigicmVw
cm8tZGlyIiwgT19QQVRIKTsKCWlmIChwYXJlbnRfZmQgPCAwKQoJCWRpZSgib3BlbiByZXByby1k
aXIgT19QQVRIIik7CgoJc3RydWN0IGxhbmRsb2NrX3BhdGhfYmVuZWF0aF9hdHRyIHBhdGhfYmVu
ZWF0aCA9IHsKCQkuYWxsb3dlZF9hY2Nlc3MgPSBMQU5ETE9DS19BQ0NFU1NfRlNfRVhFQ1VURSwK
CQkucGFyZW50X2ZkID0gcGFyZW50X2ZkLAoJfTsKCWlmIChsYW5kbG9ja19hZGRfcnVsZShydWxl
c2V0X2ZkLCBMQU5ETE9DS19SVUxFX1BBVEhfQkVORUFUSCwKCQkJICAgICAgICZwYXRoX2JlbmVh
dGgsIDApICE9IDApCgkJZGllKCJsYW5kbG9ja19hZGRfcnVsZSIpOwoJY2xvc2UocGFyZW50X2Zk
KTsKCglpZiAocHJjdGwoUFJfU0VUX05PX05FV19QUklWUywgMSwgMCwgMCwgMCkgIT0gMCkKCQlk
aWUoInByY3RsKFBSX1NFVF9OT19ORVdfUFJJVlMpIik7CgoJaWYgKGxhbmRsb2NrX3Jlc3RyaWN0
X3NlbGYocnVsZXNldF9mZCwgMCkgIT0gMCkKCQlkaWUoImxhbmRsb2NrX3Jlc3RyaWN0X3NlbGYi
KTsKCWNsb3NlKHJ1bGVzZXRfZmQpOwoKCXByaW50ZigiTGFuZGxvY2sgcnVsZXNldCBpbnN0YWxs
ZWQ6IEVYRUNVVEUtb25seSwgb25lIFBhdGhCZW5lYXRoICIKCSAgICAgICAicnVsZSBhbmNob3Jl
ZCBvbiByZXByby1kaXIgKHRoZSB0YXJnZXQgZmlsZSdzIG93biBwYXJlbnQpLlxuIik7CgoJaW50
IHJlc3VsdCA9IHRyeV9leGVjdmUoInJlcHJvLWRpci9leGUiKTsKCWlmIChyZXN1bHQgPT0gMCkg
ewoJCXByaW50ZigiUEFTUzogZXhlY3ZlIHN1Y2NlZWRlZCwgYXMgdGhlIHVwc3RyZWFtIHNlbGZ0
ZXN0ICIKCQkgICAgICAgIihsYXlvdXQxLmV4ZWN1dGUsIGZpbGUxX3MxZDIgY2FzZSkgZXhwZWN0
cy5cbiIpOwoJfSBlbHNlIHsKCQlwcmludGYoIkZBSUw6IGV4ZWN2ZSB3YXMgZGVuaWVkIChFQUND
RVMpIGRlc3BpdGUgYW4gIgoJCSAgICAgICAiZXhwbGljaXQsIGNvcnJlY3RseS1hbmNob3JlZCBQ
YXRoQmVuZWF0aCBydWxlICIKCQkgICAgICAgImdyYW50aW5nIExBTkRMT0NLX0FDQ0VTU19GU19F
WEVDVVRFIG9uIHRoZSBmaWxlJ3MgIgoJCSAgICAgICAib3duIHBhcmVudCBkaXJlY3RvcnkgLS0g
dGhpcyBjb250cmFkaWN0cyAiCgkJICAgICAgICJ0b29scy90ZXN0aW5nL3NlbGZ0ZXN0cy9sYW5k
bG9jay9mc190ZXN0LmMncyAiCgkJICAgICAgICJURVNUX0ZfRk9SSyhsYXlvdXQxLCBleGVjdXRl
KSBleHBlY3RhdGlvbiBmb3IgdGhlICIKCQkgICAgICAgImZpbGUxX3MxZDIgY2FzZS5cbiIpOwoJ
fQoKCXN5c3RlbSgicm0gLXJmIHJlcHJvLWRpciIpOwoJcmV0dXJuIHJlc3VsdDsKfQo=
-----------------------a13646fe735a870407e4d755e7eb20de
Content-Type: text/x-log; filename="official-selftest-output.log"; name="official-selftest-output.log"
Content-Transfer-Encoding: base64
Content-Disposition: attachment; filename="official-selftest-output.log"; name="official-selftest-output.log"

VEFQIHZlcnNpb24gMTMKMS4uNjgKIyBTdGFydGluZyA2OCB0ZXN0cyBmcm9tIDEgdGVzdCBjYXNl
cy4KIyAgUlVOICAgICAgICAgICBsYXlvdXQxLm5vX3Jlc3RyaWN0aW9uIC4uLgojICAgICAgICAg
ICAgT0sgIGxheW91dDEubm9fcmVzdHJpY3Rpb24Kb2sgMSBsYXlvdXQxLm5vX3Jlc3RyaWN0aW9u
CiMgIFJVTiAgICAgICAgICAgbGF5b3V0MS5pbnZhbCAuLi4KIyAgICAgICAgICAgIE9LICBsYXlv
dXQxLmludmFsCm9rIDIgbGF5b3V0MS5pbnZhbAojICBSVU4gICAgICAgICAgIGxheW91dDEuZmls
ZV9hbmRfZGlyX2FjY2Vzc19yaWdodHMgLi4uCiMgICAgICAgICAgICBPSyAgbGF5b3V0MS5maWxl
X2FuZF9kaXJfYWNjZXNzX3JpZ2h0cwpvayAzIGxheW91dDEuZmlsZV9hbmRfZGlyX2FjY2Vzc19y
aWdodHMKIyAgUlVOICAgICAgICAgICBsYXlvdXQxLnJ1bGVfd2l0aF91bmhhbmRsZWRfYWNjZXNz
IC4uLgojICAgICAgICAgICAgT0sgIGxheW91dDEucnVsZV93aXRoX3VuaGFuZGxlZF9hY2Nlc3MK
b2sgNCBsYXlvdXQxLnJ1bGVfd2l0aF91bmhhbmRsZWRfYWNjZXNzCiMgIFJVTiAgICAgICAgICAg
bGF5b3V0MS5lZmZlY3RpdmVfYWNjZXNzIC4uLgojICAgICAgICAgICAgT0sgIGxheW91dDEuZWZm
ZWN0aXZlX2FjY2VzcwpvayA1IGxheW91dDEuZWZmZWN0aXZlX2FjY2VzcwojICBSVU4gICAgICAg
ICAgIGxheW91dDEudW5oYW5kbGVkX2FjY2VzcyAuLi4KIyAgICAgICAgICAgIE9LICBsYXlvdXQx
LnVuaGFuZGxlZF9hY2Nlc3MKb2sgNiBsYXlvdXQxLnVuaGFuZGxlZF9hY2Nlc3MKIyAgUlVOICAg
ICAgICAgICBsYXlvdXQxLnJ1bGVzZXRfb3ZlcmxhcCAuLi4KIyAgICAgICAgICAgIE9LICBsYXlv
dXQxLnJ1bGVzZXRfb3ZlcmxhcApvayA3IGxheW91dDEucnVsZXNldF9vdmVybGFwCiMgIFJVTiAg
ICAgICAgICAgbGF5b3V0MS5sYXllcl9ydWxlX3VuaW9ucyAuLi4KIyAgICAgICAgICAgIE9LICBs
YXlvdXQxLmxheWVyX3J1bGVfdW5pb25zCm9rIDggbGF5b3V0MS5sYXllcl9ydWxlX3VuaW9ucwoj
ICBSVU4gICAgICAgICAgIGxheW91dDEubm9uX292ZXJsYXBwaW5nX2FjY2Vzc2VzIC4uLgojICAg
ICAgICAgICAgT0sgIGxheW91dDEubm9uX292ZXJsYXBwaW5nX2FjY2Vzc2VzCm9rIDkgbGF5b3V0
MS5ub25fb3ZlcmxhcHBpbmdfYWNjZXNzZXMKIyAgUlVOICAgICAgICAgICBsYXlvdXQxLmludGVy
bGVhdmVkX21hc2tlZF9hY2Nlc3NlcyAuLi4KIyAgICAgICAgICAgIE9LICBsYXlvdXQxLmludGVy
bGVhdmVkX21hc2tlZF9hY2Nlc3NlcwpvayAxMCBsYXlvdXQxLmludGVybGVhdmVkX21hc2tlZF9h
Y2Nlc3NlcwojICBSVU4gICAgICAgICAgIGxheW91dDEuaW5oZXJpdF9zdWJzZXQgLi4uCiMgICAg
ICAgICAgICBPSyAgbGF5b3V0MS5pbmhlcml0X3N1YnNldApvayAxMSBsYXlvdXQxLmluaGVyaXRf
c3Vic2V0CiMgIFJVTiAgICAgICAgICAgbGF5b3V0MS5pbmhlcml0X3N1cGVyc2V0IC4uLgojICAg
ICAgICAgICAgT0sgIGxheW91dDEuaW5oZXJpdF9zdXBlcnNldApvayAxMiBsYXlvdXQxLmluaGVy
aXRfc3VwZXJzZXQKIyAgUlVOICAgICAgICAgICBsYXlvdXQxLmVtcHR5X29yX3NhbWVfcnVsZXNl
dCAuLi4KIyAgICAgICAgICAgIE9LICBsYXlvdXQxLmVtcHR5X29yX3NhbWVfcnVsZXNldApvayAx
MyBsYXlvdXQxLmVtcHR5X29yX3NhbWVfcnVsZXNldAojICBSVU4gICAgICAgICAgIGxheW91dDEu
cnVsZV9vbl9tb3VudHBvaW50IC4uLgojICAgICAgICAgICAgT0sgIGxheW91dDEucnVsZV9vbl9t
b3VudHBvaW50Cm9rIDE0IGxheW91dDEucnVsZV9vbl9tb3VudHBvaW50CiMgIFJVTiAgICAgICAg
ICAgbGF5b3V0MS5ydWxlX292ZXJfbW91bnRwb2ludCAuLi4KIyAgICAgICAgICAgIE9LICBsYXlv
dXQxLnJ1bGVfb3Zlcl9tb3VudHBvaW50Cm9rIDE1IGxheW91dDEucnVsZV9vdmVyX21vdW50cG9p
bnQKIyAgUlVOICAgICAgICAgICBsYXlvdXQxLnJ1bGVfb3Zlcl9yb290X2FsbG93X3RoZW5fZGVu
eSAuLi4KIyAgICAgICAgICAgIE9LICBsYXlvdXQxLnJ1bGVfb3Zlcl9yb290X2FsbG93X3RoZW5f
ZGVueQpvayAxNiBsYXlvdXQxLnJ1bGVfb3Zlcl9yb290X2FsbG93X3RoZW5fZGVueQojICBSVU4g
ICAgICAgICAgIGxheW91dDEucnVsZV9vdmVyX3Jvb3RfZGVueSAuLi4KIyAgICAgICAgICAgIE9L
ICBsYXlvdXQxLnJ1bGVfb3Zlcl9yb290X2RlbnkKb2sgMTcgbGF5b3V0MS5ydWxlX292ZXJfcm9v
dF9kZW55CiMgIFJVTiAgICAgICAgICAgbGF5b3V0MS5ydWxlX2luc2lkZV9tb3VudF9ucyAuLi4K
IyAgICAgICAgICAgIE9LICBsYXlvdXQxLnJ1bGVfaW5zaWRlX21vdW50X25zCm9rIDE4IGxheW91
dDEucnVsZV9pbnNpZGVfbW91bnRfbnMKIyAgUlVOICAgICAgICAgICBsYXlvdXQxLm1vdW50X2Fu
ZF9waXZvdCAuLi4KIyAgICAgICAgICAgIE9LICBsYXlvdXQxLm1vdW50X2FuZF9waXZvdApvayAx
OSBsYXlvdXQxLm1vdW50X2FuZF9waXZvdAojICBSVU4gICAgICAgICAgIGxheW91dDEubW92ZV9t
b3VudCAuLi4KIyAgICAgICAgICAgIE9LICBsYXlvdXQxLm1vdmVfbW91bnQKb2sgMjAgbGF5b3V0
MS5tb3ZlX21vdW50CiMgIFJVTiAgICAgICAgICAgbGF5b3V0MS50b3BvbG9neV9jaGFuZ2VzX3dp
dGhfbmV0X29ubHkgLi4uCiMgICAgICAgICAgICBPSyAgbGF5b3V0MS50b3BvbG9neV9jaGFuZ2Vz
X3dpdGhfbmV0X29ubHkKb2sgMjEgbGF5b3V0MS50b3BvbG9neV9jaGFuZ2VzX3dpdGhfbmV0X29u
bHkKIyAgUlVOICAgICAgICAgICBsYXlvdXQxLnRvcG9sb2d5X2NoYW5nZXNfd2l0aF9uZXRfYW5k
X2ZzIC4uLgojICAgICAgICAgICAgT0sgIGxheW91dDEudG9wb2xvZ3lfY2hhbmdlc193aXRoX25l
dF9hbmRfZnMKb2sgMjIgbGF5b3V0MS50b3BvbG9neV9jaGFuZ2VzX3dpdGhfbmV0X2FuZF9mcwoj
ICBSVU4gICAgICAgICAgIGxheW91dDEucmVsZWFzZV9pbm9kZXMgLi4uCiMgICAgICAgICAgICBP
SyAgbGF5b3V0MS5yZWxlYXNlX2lub2RlcwpvayAyMyBsYXlvdXQxLnJlbGVhc2VfaW5vZGVzCiMg
IFJVTiAgICAgICAgICAgbGF5b3V0MS5jb3ZlcmVkX3J1bGUgLi4uCiMgICAgICAgICAgICBPSyAg
bGF5b3V0MS5jb3ZlcmVkX3J1bGUKb2sgMjQgbGF5b3V0MS5jb3ZlcmVkX3J1bGUKIyAgUlVOICAg
ICAgICAgICBsYXlvdXQxLnJlbGF0aXZlX29wZW4gLi4uCiMgICAgICAgICAgICBPSyAgbGF5b3V0
MS5yZWxhdGl2ZV9vcGVuCm9rIDI1IGxheW91dDEucmVsYXRpdmVfb3BlbgojICBSVU4gICAgICAg
ICAgIGxheW91dDEucmVsYXRpdmVfY2hkaXIgLi4uCiMgICAgICAgICAgICBPSyAgbGF5b3V0MS5y
ZWxhdGl2ZV9jaGRpcgpvayAyNiBsYXlvdXQxLnJlbGF0aXZlX2NoZGlyCiMgIFJVTiAgICAgICAg
ICAgbGF5b3V0MS5yZWxhdGl2ZV9jaHJvb3Rfb25seSAuLi4KIyAgICAgICAgICAgIE9LICBsYXlv
dXQxLnJlbGF0aXZlX2Nocm9vdF9vbmx5Cm9rIDI3IGxheW91dDEucmVsYXRpdmVfY2hyb290X29u
bHkKIyAgUlVOICAgICAgICAgICBsYXlvdXQxLnJlbGF0aXZlX2Nocm9vdF9jaGRpciAuLi4KIyAg
ICAgICAgICAgIE9LICBsYXlvdXQxLnJlbGF0aXZlX2Nocm9vdF9jaGRpcgpvayAyOCBsYXlvdXQx
LnJlbGF0aXZlX2Nocm9vdF9jaGRpcgojICBSVU4gICAgICAgICAgIGxheW91dDEuZXhlY3V0ZSAu
Li4KIyBmc190ZXN0LmM6MTk0OTpleGVjdXRlOkV4cGVjdGVkIGVyciA/IC0xIDogMCAoMCkgPT0g
ZXhlY3ZlKHBhdGgsIGFyZ3YsIE5VTEwpICgtMSkKIyBmc190ZXN0LmM6MTk1MTpleGVjdXRlOkZh
aWxlZCB0byBleGVjdXRlICJ0bXAvczFkMS9zMWQyL2YxIjogUGVybWlzc2lvbiBkZW5pZWQKIyBl
eGVjdXRlOiBUZXN0IHRlcm1pbmF0ZWQgYnkgYXNzZXJ0aW9uCiMgICAgICAgICAgRkFJTCAgbGF5
b3V0MS5leGVjdXRlCm5vdCBvayAyOSBsYXlvdXQxLmV4ZWN1dGUKIyAgUlVOICAgICAgICAgICBs
YXlvdXQxLnVtb3VudF9zYW5kYm94ZXIgLi4uCiMgZnNfdGVzdC5jOjE5Mjk6dW1vdW50X3NhbmRi
b3hlcjpFeHBlY3RlZCAwICgwKSA8PSBzcmNfZmQgKC0xKQojIGZzX3Rlc3QuYzoxOTMxOnVtb3Vu
dF9zYW5kYm94ZXI6RmFpbGVkIHRvIG9wZW4gIi4vc2FuZGJveC1hbmQtbGF1bmNoIjogTm8gc3Vj
aCBmaWxlIG9yIGRpcmVjdG9yeQojIHVtb3VudF9zYW5kYm94ZXI6IFRlc3QgdGVybWluYXRlZCBi
eSBhc3NlcnRpb24KIyAgICAgICAgICBGQUlMICBsYXlvdXQxLnVtb3VudF9zYW5kYm94ZXIKbm90
IG9rIDMwIGxheW91dDEudW1vdW50X3NhbmRib3hlcgojICBSVU4gICAgICAgICAgIGxheW91dDEu
bGluayAuLi4KIyAgICAgICAgICAgIE9LICBsYXlvdXQxLmxpbmsKb2sgMzEgbGF5b3V0MS5saW5r
CiMgIFJVTiAgICAgICAgICAgbGF5b3V0MS5yZW5hbWVfZmlsZSAuLi4KIyAgICAgICAgICAgIE9L
ICBsYXlvdXQxLnJlbmFtZV9maWxlCm9rIDMyIGxheW91dDEucmVuYW1lX2ZpbGUKIyAgUlVOICAg
ICAgICAgICBsYXlvdXQxLnJlbmFtZV9kaXIgLi4uCiMgICAgICAgICAgICBPSyAgbGF5b3V0MS5y
ZW5hbWVfZGlyCm9rIDMzIGxheW91dDEucmVuYW1lX2RpcgojICBSVU4gICAgICAgICAgIGxheW91
dDEucmVwYXJlbnRfcmVmZXIgLi4uCiMgICAgICAgICAgICBPSyAgbGF5b3V0MS5yZXBhcmVudF9y
ZWZlcgpvayAzNCBsYXlvdXQxLnJlcGFyZW50X3JlZmVyCiMgIFJVTiAgICAgICAgICAgbGF5b3V0
MS5yZWZlcl9kZW5pZWRfYnlfZGVmYXVsdDEgLi4uCiMgICAgICAgICAgICBPSyAgbGF5b3V0MS5y
ZWZlcl9kZW5pZWRfYnlfZGVmYXVsdDEKb2sgMzUgbGF5b3V0MS5yZWZlcl9kZW5pZWRfYnlfZGVm
YXVsdDEKIyAgUlVOICAgICAgICAgICBsYXlvdXQxLnJlZmVyX2RlbmllZF9ieV9kZWZhdWx0MiAu
Li4KIyAgICAgICAgICAgIE9LICBsYXlvdXQxLnJlZmVyX2RlbmllZF9ieV9kZWZhdWx0MgpvayAz
NiBsYXlvdXQxLnJlZmVyX2RlbmllZF9ieV9kZWZhdWx0MgojICBSVU4gICAgICAgICAgIGxheW91
dDEucmVmZXJfZGVuaWVkX2J5X2RlZmF1bHQzIC4uLgojICAgICAgICAgICAgT0sgIGxheW91dDEu
cmVmZXJfZGVuaWVkX2J5X2RlZmF1bHQzCm9rIDM3IGxheW91dDEucmVmZXJfZGVuaWVkX2J5X2Rl
ZmF1bHQzCiMgIFJVTiAgICAgICAgICAgbGF5b3V0MS5yZWZlcl9kZW5pZWRfYnlfZGVmYXVsdDQg
Li4uCiMgICAgICAgICAgICBPSyAgbGF5b3V0MS5yZWZlcl9kZW5pZWRfYnlfZGVmYXVsdDQKb2sg
MzggbGF5b3V0MS5yZWZlcl9kZW5pZWRfYnlfZGVmYXVsdDQKIyAgUlVOICAgICAgICAgICBsYXlv
dXQxLnJlZmVyX21vdW50X3Jvb3RfZGVueSAuLi4KIyAgICAgICAgICAgIE9LICBsYXlvdXQxLnJl
ZmVyX21vdW50X3Jvb3RfZGVueQpvayAzOSBsYXlvdXQxLnJlZmVyX21vdW50X3Jvb3RfZGVueQoj
ICBSVU4gICAgICAgICAgIGxheW91dDEucmVmZXJfcGFydF9tb3VudF90cmVlX2lzX2FsbG93ZWQg
Li4uCiMgICAgICAgICAgICBPSyAgbGF5b3V0MS5yZWZlcl9wYXJ0X21vdW50X3RyZWVfaXNfYWxs
b3dlZApvayA0MCBsYXlvdXQxLnJlZmVyX3BhcnRfbW91bnRfdHJlZV9pc19hbGxvd2VkCiMgIFJV
TiAgICAgICAgICAgbGF5b3V0MS5yZXBhcmVudF9saW5rIC4uLgojICAgICAgICAgICAgT0sgIGxh
eW91dDEucmVwYXJlbnRfbGluawpvayA0MSBsYXlvdXQxLnJlcGFyZW50X2xpbmsKIyAgUlVOICAg
ICAgICAgICBsYXlvdXQxLnJlcGFyZW50X3JlbmFtZSAuLi4KIyAgICAgICAgICAgIE9LICBsYXlv
dXQxLnJlcGFyZW50X3JlbmFtZQpvayA0MiBsYXlvdXQxLnJlcGFyZW50X3JlbmFtZQojICBSVU4g
ICAgICAgICAgIGxheW91dDEucmVwYXJlbnRfZXhkZXZfbGF5ZXJzX3JlbmFtZTEgLi4uCiMgICAg
ICAgICAgICBPSyAgbGF5b3V0MS5yZXBhcmVudF9leGRldl9sYXllcnNfcmVuYW1lMQpvayA0MyBs
YXlvdXQxLnJlcGFyZW50X2V4ZGV2X2xheWVyc19yZW5hbWUxCiMgIFJVTiAgICAgICAgICAgbGF5
b3V0MS5yZXBhcmVudF9leGRldl9sYXllcnNfcmVuYW1lMiAuLi4KIyAgICAgICAgICAgIE9LICBs
YXlvdXQxLnJlcGFyZW50X2V4ZGV2X2xheWVyc19yZW5hbWUyCm9rIDQ0IGxheW91dDEucmVwYXJl
bnRfZXhkZXZfbGF5ZXJzX3JlbmFtZTIKIyAgUlVOICAgICAgICAgICBsYXlvdXQxLnJlcGFyZW50
X2V4ZGV2X2xheWVyc19leGNoYW5nZTEgLi4uCiMgICAgICAgICAgICBPSyAgbGF5b3V0MS5yZXBh
cmVudF9leGRldl9sYXllcnNfZXhjaGFuZ2UxCm9rIDQ1IGxheW91dDEucmVwYXJlbnRfZXhkZXZf
bGF5ZXJzX2V4Y2hhbmdlMQojICBSVU4gICAgICAgICAgIGxheW91dDEucmVwYXJlbnRfZXhkZXZf
bGF5ZXJzX2V4Y2hhbmdlMiAuLi4KIyAgICAgICAgICAgIE9LICBsYXlvdXQxLnJlcGFyZW50X2V4
ZGV2X2xheWVyc19leGNoYW5nZTIKb2sgNDYgbGF5b3V0MS5yZXBhcmVudF9leGRldl9sYXllcnNf
ZXhjaGFuZ2UyCiMgIFJVTiAgICAgICAgICAgbGF5b3V0MS5yZXBhcmVudF9leGRldl9sYXllcnNf
ZXhjaGFuZ2UzIC4uLgojICAgICAgICAgICAgT0sgIGxheW91dDEucmVwYXJlbnRfZXhkZXZfbGF5
ZXJzX2V4Y2hhbmdlMwpvayA0NyBsYXlvdXQxLnJlcGFyZW50X2V4ZGV2X2xheWVyc19leGNoYW5n
ZTMKIyAgUlVOICAgICAgICAgICBsYXlvdXQxLnJlcGFyZW50X3JlbW92ZSAuLi4KIyAgICAgICAg
ICAgIE9LICBsYXlvdXQxLnJlcGFyZW50X3JlbW92ZQpvayA0OCBsYXlvdXQxLnJlcGFyZW50X3Jl
bW92ZQojICBSVU4gICAgICAgICAgIGxheW91dDEucmVwYXJlbnRfZG9tX3N1cGVyc2V0IC4uLgoj
ICAgICAgICAgICAgT0sgIGxheW91dDEucmVwYXJlbnRfZG9tX3N1cGVyc2V0Cm9rIDQ5IGxheW91
dDEucmVwYXJlbnRfZG9tX3N1cGVyc2V0CiMgIFJVTiAgICAgICAgICAgbGF5b3V0MS5yZW1vdmVf
ZGlyIC4uLgojICAgICAgICAgICAgT0sgIGxheW91dDEucmVtb3ZlX2RpcgpvayA1MCBsYXlvdXQx
LnJlbW92ZV9kaXIKIyAgUlVOICAgICAgICAgICBsYXlvdXQxLnJlbW92ZV9maWxlIC4uLgojICAg
ICAgICAgICAgT0sgIGxheW91dDEucmVtb3ZlX2ZpbGUKb2sgNTEgbGF5b3V0MS5yZW1vdmVfZmls
ZQojICBSVU4gICAgICAgICAgIGxheW91dDEubWFrZV9jaGFyIC4uLgojICAgICAgICAgICAgT0sg
IGxheW91dDEubWFrZV9jaGFyCm9rIDUyIGxheW91dDEubWFrZV9jaGFyCiMgIFJVTiAgICAgICAg
ICAgbGF5b3V0MS5tYWtlX2Jsb2NrIC4uLgojICAgICAgICAgICAgT0sgIGxheW91dDEubWFrZV9i
bG9jawpvayA1MyBsYXlvdXQxLm1ha2VfYmxvY2sKIyAgUlVOICAgICAgICAgICBsYXlvdXQxLm1h
a2VfcmVnXzEgLi4uCiMgICAgICAgICAgICBPSyAgbGF5b3V0MS5tYWtlX3JlZ18xCm9rIDU0IGxh
eW91dDEubWFrZV9yZWdfMQojICBSVU4gICAgICAgICAgIGxheW91dDEubWFrZV9yZWdfMiAuLi4K
IyAgICAgICAgICAgIE9LICBsYXlvdXQxLm1ha2VfcmVnXzIKb2sgNTUgbGF5b3V0MS5tYWtlX3Jl
Z18yCiMgIFJVTiAgICAgICAgICAgbGF5b3V0MS5tYWtlX3NvY2sgLi4uCiMgICAgICAgICAgICBP
SyAgbGF5b3V0MS5tYWtlX3NvY2sKb2sgNTYgbGF5b3V0MS5tYWtlX3NvY2sKIyAgUlVOICAgICAg
ICAgICBsYXlvdXQxLm1ha2VfZmlmbyAuLi4KIyAgICAgICAgICAgIE9LICBsYXlvdXQxLm1ha2Vf
ZmlmbwpvayA1NyBsYXlvdXQxLm1ha2VfZmlmbwojICBSVU4gICAgICAgICAgIGxheW91dDEubWFr
ZV9zeW0gLi4uCiMgICAgICAgICAgICBPSyAgbGF5b3V0MS5tYWtlX3N5bQpvayA1OCBsYXlvdXQx
Lm1ha2Vfc3ltCiMgIFJVTiAgICAgICAgICAgbGF5b3V0MS5tYWtlX2RpciAuLi4KIyAgICAgICAg
ICAgIE9LICBsYXlvdXQxLm1ha2VfZGlyCm9rIDU5IGxheW91dDEubWFrZV9kaXIKIyAgUlVOICAg
ICAgICAgICBsYXlvdXQxLnByb2NfdW5saW5rZWRfZmlsZSAuLi4KIyAgICAgICAgICAgIE9LICBs
YXlvdXQxLnByb2NfdW5saW5rZWRfZmlsZQpvayA2MCBsYXlvdXQxLnByb2NfdW5saW5rZWRfZmls
ZQojICBSVU4gICAgICAgICAgIGxheW91dDEucHJvY19waXBlIC4uLgojICAgICAgICAgICAgT0sg
IGxheW91dDEucHJvY19waXBlCm9rIDYxIGxheW91dDEucHJvY19waXBlCiMgIFJVTiAgICAgICAg
ICAgbGF5b3V0MS50cnVuY2F0ZV91bmhhbmRsZWQgLi4uCiMgICAgICAgICAgICBPSyAgbGF5b3V0
MS50cnVuY2F0ZV91bmhhbmRsZWQKb2sgNjIgbGF5b3V0MS50cnVuY2F0ZV91bmhhbmRsZWQKIyAg
UlVOICAgICAgICAgICBsYXlvdXQxLnRydW5jYXRlIC4uLgojICAgICAgICAgICAgT0sgIGxheW91
dDEudHJ1bmNhdGUKb2sgNjMgbGF5b3V0MS50cnVuY2F0ZQojICBSVU4gICAgICAgICAgIGxheW91
dDEuZnRydW5jYXRlIC4uLgojICAgICAgICAgICAgT0sgIGxheW91dDEuZnRydW5jYXRlCm9rIDY0
IGxheW91dDEuZnRydW5jYXRlCiMgIFJVTiAgICAgICAgICAgbGF5b3V0MS5vX3BhdGhfZnRydW5j
YXRlX2FuZF9pb2N0bCAuLi4KIyAgICAgICAgICAgIE9LICBsYXlvdXQxLm9fcGF0aF9mdHJ1bmNh
dGVfYW5kX2lvY3RsCm9rIDY1IGxheW91dDEub19wYXRoX2Z0cnVuY2F0ZV9hbmRfaW9jdGwKIyAg
UlVOICAgICAgICAgICBsYXlvdXQxLmJsYW5rZXRfcGVybWl0dGVkX2lvY3RscyAuLi4KIyAgICAg
ICAgICAgIE9LICBsYXlvdXQxLmJsYW5rZXRfcGVybWl0dGVkX2lvY3RscwpvayA2NiBsYXlvdXQx
LmJsYW5rZXRfcGVybWl0dGVkX2lvY3RscwojICBSVU4gICAgICAgICAgIGxheW91dDEubmFtZWRf
cGlwZV9pb2N0bCAuLi4KIyAgICAgICAgICAgIE9LICBsYXlvdXQxLm5hbWVkX3BpcGVfaW9jdGwK
b2sgNjcgbGF5b3V0MS5uYW1lZF9waXBlX2lvY3RsCiMgIFJVTiAgICAgICAgICAgbGF5b3V0MS5u
YW1lZF91bml4X2RvbWFpbl9zb2NrZXRfaW9jdGwgLi4uCiMgICAgICAgICAgICBPSyAgbGF5b3V0
MS5uYW1lZF91bml4X2RvbWFpbl9zb2NrZXRfaW9jdGwKb2sgNjggbGF5b3V0MS5uYW1lZF91bml4
X2RvbWFpbl9zb2NrZXRfaW9jdGwKIyBGQUlMRUQ6IDY2IC8gNjggdGVzdHMgcGFzc2VkLgojIFRv
dGFsczogcGFzczo2NiBmYWlsOjIgeGZhaWw6MCB4cGFzczowIHNraXA6MCBlcnJvcjowCg==
-----------------------a13646fe735a870407e4d755e7eb20de
Content-Type: application/pgp-keys; filename="publickey - ken@kengrimes.com - 0xEDFCC5BC.asc"; name="publickey - ken@kengrimes.com - 0xEDFCC5BC.asc"
Content-Transfer-Encoding: base64
Content-Disposition: attachment; filename="publickey - ken@kengrimes.com - 0xEDFCC5BC.asc"; name="publickey - ken@kengrimes.com - 0xEDFCC5BC.asc"

LS0tLS1CRUdJTiBQR1AgUFVCTElDIEtFWSBCTE9DSy0tLS0tCgp4ak1FWDIvT0xSWUpLd1lCQkFI
YVJ3OEJBUWRBMGIwS2EwWlVWWEpSenNtNG05bFM5blZ0ODlhM1RKQjMKMU9yVEtSS3lKZ1hOSld0
bGJrQnJaVzVuY21sdFpYTXVZMjl0SUR4clpXNUFhMlZ1WjNKcGJXVnpMbU52CmJUN0Nqd1FRRmdv
QUlBVUNYMi9PTFFZTENRY0lBd0lFRlFnS0FnUVdBZ0VBQWhrQkFoc0RBaDRCQUNFSgpFRk0rYjdl
S1piZ2hGaUVFN2Z6RnZDc2Y0bURSTVBtNVV6NXZ0NHBsdUNGWE1BRCtPNGRCS2RoTGNVWFcKbGx0
eFp4MXNZNjFnRVVYNEVId0s1UUdHTjg4VHRjVUJBTU9qMDFQclcrZVI2dWhkZ3M4enlDZ1hTa2xl
CkVNVlplcDBMeTVMWUkwd1B6amdFWDIvT0xSSUtLd1lCQkFHWFZRRUZBUUVIUUxvU2ptbG10Z01j
akFMUwpLMWE5OEZnWURzRDloK3B0SFBNM05XNmFiaUI3QXdFSUI4SjRCQmdXQ0FBSkJRSmZiODR0
QWhzTUFDRUoKRUZNK2I3ZUtaYmdoRmlFRTdmekZ2Q3NmNG1EUk1QbTVVejV2dDRwbHVDRlR5QUQv
UUlvbC9nVUJjZXBlCkVHdjJnZXd3L0hmV0tYY2d2K2VLZ3dib0YvRFpuc2tBLzN0cm56V201QzBp
S3ovajdJRzFwUFNpZmJKcwp3QzZGR1FxOE80ZVlvSHdGCj1GRlVoCi0tLS0tRU5EIFBHUCBQVUJM
SUMgS0VZIEJMT0NLLS0tLS0K
-----------------------a13646fe735a870407e4d755e7eb20de--

--------5557844a03d65874aeb395be5c33d83a882950f6f3227c988e34e53309cb6be2
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: ProtonMail

wrsEARYKAG0FgmpWpR4JEFM+b7eKZbghRRQAAAAAABwAIHNhbHRAbm90YXRp
b25zLm9wZW5wZ3Bqcy5vcmcXRzpg3YYBj7YV+F6sddNy9Bpai453FihsJRyo
xZO2yxYhBO38xbwrH+Jg0TD5uVM+b7eKZbghAABpnQD/QAm5zkrpgZfxlv8I
yiBG3lSaFcql5W0Kyh6gFWVWpHkA/RvGt6+fJbwIIuE9q8zr6ZfWU1OC5r8k
J1VAZQsbTqwE
=QduJ
-----END PGP SIGNATURE-----


--------5557844a03d65874aeb395be5c33d83a882950f6f3227c988e34e53309cb6be2--

