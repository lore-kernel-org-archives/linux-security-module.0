Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795311551;
	b=vV3my7hSdNFUCxpZ8xjZeXG6tkH89eMzVwmw9LIo5qOkytzWA6krYW892uWvMB4yE0GI
	 YzdCuf+yzeGZNcEnKMr29zMofHIyc/hWQc2qSSbcG+VtW+jFk6z7b0aB+hgye+uT1tdQv
	 AZgfmnApiuxJhzKKBtlDvcJRTEbSBUGSdoOLAwVvFD+3H4CCOCIwDOF1+d0qMfBIWHUf0
	 oWMvxQoWuwui9SruZgBkig7PcvwVPAFU2/OkhI6PdL/Vico0V7dcwWvukpEYsRjmM4aJv
	 d/FQpmgrImjGCEUmarJrIALSKS3Ve9cHvh7+JQQKEmwGclg5sB8M0WpRD1boSuiPgSQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795311551;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=kNajklT4NWRuvO4tlojLaU4FTOaYuorZJL8FQmjQkns=;
	b=AFR9ZVaA4AWRrmqtnlSISs17CnSO1pq8+T4SNpWRnugjngLHkFZwUZhvdMRePnygFEHH
	 NtV1KpAsKLf16bKnqPYBM0od+j3AnDeYW9I7s6s2IxLrsfIq0m29u+eGsLimu2d2Phczm
	 h209pJKZAilNR9clXMRKjLZe+he70WlJuRhqFzrr7AAB/+dDlktWtmHPAnzKoEo1jrWjK
	 6lynmO8kAwriNoe4QF01PKZoavr1EyVvyHbcJ9hwHvv1Xw1L+8EMmKu/O+78HmpDMJx/0
	 cdqDa1YXDlLSLvzWDnVb8fqs4gacGlT/XPXJOEh3lOAwziac19I0AtetoR7wp7lVV6w==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Ea3+EMLq;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3A175606A32C;
	Sun, 22 Nov 2026 01:39:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Ea3+EMLq
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DD50C1F000CF;
	Sun, 22 Nov 2026 01:39:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795311551;
	bh=kNajklT4NWRuvO4tlojLaU4FTOaYuorZJL8FQmjQkns=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=Ea3+EMLqjbQ7qRwbgCzK72nDD3YzZxWc1ejtUmKtpm9Lrr3/e6OuxoRh+5RMhVCsN
	 BZWuGk0Bt7/F+krh5/ygopq7dBx48ThSHbOSMMC8cTspbSKNNuw3RjUn4SwSKTWbQV
	 7BNjzqFIQQqcN/BHxkGsOAVmgcUiAshbKS6bPDq6X2LUSnFc9Nh7i1ti+oCIwcuYMa
	 tnXAWhjoz51Rz4t0myRbUv0viKkltsiVJ3f5M6tVl/dtg4BxvVjj9BojY7YOC1/3Xq
	 vXiF1rDkzkLVwb4lwyAHatrNxUwQnSY10RRforwNqLbpx5RvP8nlGumxKzU9/gfZ/V
	 l/gDihNp8yKWQ==
Message-ID: <sashiko-outbox-227627@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [RFC PATCH v6 25/26] selftests/userland: Add userland test
 suite
Reply-To: sashiko-reviews@lists.linux.dev
To: "Jarkko Sakkinen" <jarkko@kernel.org>
Cc: bpf@vger.kernel.org, linux-mm@kvack.org, linux-security-module@vger.kernel.org, "Aleksa
 Sarai" <aleksa@amutable.com>, "Alexander Mikhalitsyn" <alex@amutable.com>, "Alexander
 Viro" <viro@zeniv.linux.org.uk>, "Andy Lutomirski" <luto@amacapital.net>, "Arnd
 Bergmann" <arnd@arndb.de>, "Christian Brauner" <brauner@kernel.org>, "David
 Howells" <dhowells@redhat.com>, "Giuseppe Scrivano" <giuseppe@scrivano.org>, "Hugh
 Dickins" <hughd@google.com>, "Jan Kara" <jack@suse.cz>, "Jeff Layton" <jlayton@kernel.org>, "Jonathan
 Corbet" <corbet@lwn.net>, "Josef Bacik" <josef@toxicpanda.com>, "Kees Cook" <kees@kernel.org>, "KP
 Singh" <kpsingh@kernel.org>, "Lennart Poettering" <lennart@poettering.net>, "Neal
 Gompa" <neal@gompa.dev>, "Oleg Nesterov" <oleg@redhat.com>, "Paul Moore" <paul@paul-moore.com>, "Pavel
 Tikhomirov" <ptikhomirov@virtuozzo.com>, "Serge Hallyn" <sergeh@kernel.org>, "Shuah
 Khan" <skhan@linuxfoundation.org>, "Zygmunt Krynicki" <zygmunt.krynicki@canonical.com>
In-Reply-To: <20261122011809.2667684-26-jarkko@kernel.org>
References: <20261122011809.2667684-1-jarkko@kernel.org>
 <20261122011809.2667684-26-jarkko@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sun, 22 Nov 2026 01:39:09 +0000
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Post: <mailto:linux-security-module@vger.kernel.org>
List-Help: <mailto:linux-security-module+help@vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-security-module+owner@vger.kernel.org>
Precedence: list

Thank you for your contribution! Sashiko AI review found 3 potential
issues to consider:
- [Medium] selftests/userland: host /tmp mount leak in
  check_child_src_slave_locking()
- [Medium] selftests/userland: 64K-page E2BIG failure in
  test_userns_set_idmap()
- [Low] selftests/userland: Python 3.10+ parenthesized with-statements
  in test
--

commit ceac0bb92c4f38107df4d9a282065b54c6373344
Author: Jarkko Sakkinen <jarkko@kernel.org>

selftests/userland: Add userland test suite

This commit adds a kselftest suite for the userland control object uAPI,
covering namespace sharing, mount-namespace configuration, waitid(P_USERLAN=
D),
pidfd_send_signal(), and userns_set_idmap().

> diff --git a/tools/testing/selftests/userland/userland_test.py b/tools/te=
sting/selftests/userland/userland_test.py
> new file mode 100755
> index 0000000000000..eb29cbc9c8f10
> --- /dev/null
> +++ b/tools/testing/selftests/userland/userland_test.py
> @@ -0,0 +1,2306 @@

[ ... ]

> +            with (
> +                self.closing_fd(rns.get_nsfd(CloneFlag.NEWNS)) as mntns_=
fd,
> +                self.closing_fd(rns.make_mount("tmpfs")) as rootfd,
> +            ):

[Severity: Low]
Will parenthesized multi-item with-statements fail with a SyntaxError on
Python 3.9?

Documentation/process/changes.rst specifies Python 3.9.x as the minimal
supported version, whereas parenthesized context managers across multiple
clauses were added in Python 3.10.

[ ... ]

> +            def check_child_src_slave_locking() -> None:
> +                self.enter_userns_if_unpriv()
> +                os.unshare(CloneFlag.NEWNS)
> +                with self.closing_fd(self.make_plain_mount("tmpfs")) as =
tfd:
> +                    os.mkdir("sub", 0o755, dir_fd=3Dtfd)
> +                    Sys.move_mount(
> +                        tfd,
> +                        "",
> +                        Sys.AT_FDCWD,
> +                        "/tmp",
> +                        MoveMountFlag.F_EMPTY_PATH,
> +                    )

[Severity: Medium]
When running as root, does check_child_src_slave_locking() propagate its
tmpfs mount onto the host /tmp and leave it mounted after the test exits?

enter_userns_if_unpriv() is a no-op when os.geteuid() =3D=3D 0, so
os.unshare(CloneFlag.NEWNS) stays in the initial user namespace and
preserves MS_SHARED peer groups with the host mount namespace.  Mounting
tfd onto /tmp without first calling Sys.set_mount_propagation("/") (as
check_standalone_mntns() does) propagates a fresh tmpfs over the host
/tmp, and cleanup only detaches /tmp/sub.

[ ... ]

> +            big_buf =3D ctypes.create_string_buffer(65536)
> +            with self.assertRaises(OSError) as cm:
> +                Sys.userns_set_idmap_raw(
> +                    userns_fd, ctypes.addressof(big_buf), size=3D65536
> +                )
> +            self.assertEqual(cm.exception.errno, errno.E2BIG)

[Severity: Medium]
Does this assertion fail on kernels with 64 KiB (or larger) base pages?

userns_set_idmap() returns -E2BIG only when size > PAGE_SIZE.  On a 64 KiB
page kernel, size=3D65536 passes the PAGE_SIZE check, copy_struct_from_user=
()
succeeds on the zero-filled buffer, and the syscall returns -EINVAL instead
because the extent counts are all zero.  Sizing the buffer with
os.sysconf("SC_PAGE_SIZE") + 1 would exceed PAGE_SIZE on all architectures.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261122011809.2667=
684-1-jarkko@kernel.org?part=3D25
