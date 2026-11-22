Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795377153;
	b=fvvDmxEMIZjzuGHYIjBD8sRlxbmkJ8hThvv4LE20TV05XcRdvcn4JM0l9flMzzmIlTQ8
	 egL31prIqyj4SuOnPre6OynVflPDuT6O43sMeR3zQbBP8SC/hJpA7neUG3rzUct2HC5f4
	 dEqTHAIUN/9l8lCjkH6OFtOLoJviLlGgVoS0JdIoEWsVxfIdHU0+LNsI8WXb32cFbKLCA
	 2YDGlXQ6efu1dkAgnH+dFcUuMr+fhlwAIc5onR/SjkmmcKzzErH7/HjYOpcPgX4INNEMs
	 1HOVoq8N71Qucr3musp89Xq/DKVHBsKgwtdJpWFyUzyTXlaAGiuMZp8m1hst82dat/w==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795377153;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=oB53AiQQW9kpLqFTwPLdStd+pKNNCNgAcTj6vtNksiI=;
	b=Gvszw7UYyyVe7VwHRB116j+OwTzVYoygDhykF8/5WmHLQIrGb59l5AeqKPQrWFEcv4Cl
	 BOAL5Xm5j7eQmyCRAJQ+j9Pd/nX0Cr0A1oHSA0XTog9vP4EfoK6a9TQ9FYsfMN1q1srw+
	 jmjajfOwYv5MKBBEfwTt5anra0FeoOe4q5Jg0KRu4wvK0fQFOfrLdg5lMt7yrjGlB6meR
	 GglyHfzmq/dnKu+E2diHUFzDSB9S3h5S8jWYzuIjXfbUXYjyhL/2iPMm0qQWJtbA0Otnn
	 VhIxA04+r/aj6vFF9EgWZoK6d/Dw77eZ2z6nbyYkkTMemTLNbuHlBlodMPAu3npde5w==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=UCCM8jza;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4764F606A31A;
	Sun, 22 Nov 2026 19:52:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=UCCM8jza
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7F9281F000C6;
	Sun, 22 Nov 2026 19:52:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795377152;
	bh=oB53AiQQW9kpLqFTwPLdStd+pKNNCNgAcTj6vtNksiI=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=UCCM8jzaKPGvBdMxxTt7G6+YtHW35kSK4nIHnILYexvOGzFiQGx7wbiJfTTEWQG2n
	 4KGWp0aMiu0+j5BLZk8+0GX6Srq518ciVqilMGs/gk+icFQzeznUiasFeCVLQUpnZL
	 rR2ynpIZQwyYi8sE9vCuAIhN+RGLJpZ3YU428BAav07mSf5NTBhAK4BbB46rW1LsUW
	 9Yh2qozw48I4g5Hgnp2fS2+7Z7R82FlPhPUJVN7hmMUCDNWf+5jd97Mk3RgfJVu+EF
	 4BbeRxuaY4QhSsgGPcQ5bsRRk0zibQsj8bqa330d+pn81fJW1luy4nPH/L65JCNn62
	 TLb3aIg/lTI+A==
Message-ID: <sashiko-outbox-228295@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [RFC PATCH v7 25/26] selftests/userland: Add userland test
 suite
Reply-To: sashiko-reviews@lists.linux.dev
To: "Jarkko Sakkinen" <jarkko@kernel.org>
Cc: bpf@vger.kernel.org, linux-mm@kvack.org, linux-security-module@vger.kernel.org, "Aleksa
 Sarai" <aleksa@amutable.com>, "Alexander Mikhalitsyn" <alex@amutable.com>, "Alexander
 Viro" <viro@zeniv.linux.org.uk>, "Andy Lutomirski" <luto@amacapital.net>, "Arnd
 Bergmann" <arnd@arndb.de>, "Christian Brauner" <brauner@kernel.org>, "David
 Howells" <dhowells@redhat.com>, "Eric Biggers" <ebiggers@kernel.org>, "Giuseppe
 Scrivano" <giuseppe@scrivano.org>, "Hugh Dickins" <hughd@google.com>, "Jan
 Kara" <jack@suse.cz>, "Jeff Layton" <jlayton@kernel.org>, "Jonathan Corbet" <corbet@lwn.net>, "Josef
 Bacik" <josef@toxicpanda.com>, "Kees Cook" <kees@kernel.org>, "KP Singh" <kpsingh@kernel.org>, "Lennart
 Poettering" <lennart@poettering.net>, "Neal Gompa" <neal@gompa.dev>, "Oleg
 Nesterov" <oleg@redhat.com>, "Paul Moore" <paul@paul-moore.com>, "Pavel
 Tikhomirov" <ptikhomirov@virtuozzo.com>, "Serge Hallyn" <sergeh@kernel.org>, "Shuah
 Khan" <skhan@linuxfoundation.org>, "Zygmunt Krynicki" <zygmunt.krynicki@canonical.com>
In-Reply-To: <20261122193539.3334213-26-jarkko@kernel.org>
References: <20261122193539.3334213-1-jarkko@kernel.org>
 <20261122193539.3334213-26-jarkko@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sun, 22 Nov 2026 19:52:31 +0000
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

commit cd1410a72fb4e8338db290b21743ad1e3c5bf460
Author: Jarkko Sakkinen <jarkko@kernel.org>

selftests/userland: Add userland test suite

This commit adds a kselftest suite for the userland control object,
namespace sharing, mount-namespace configuration, waitid(P_USERLAND),
pidfd_send_signal(), and userns_set_idmap().

> diff --git a/tools/testing/selftests/userland/userland_test.py b/tools/te=
sting/selftests/userland/userland_test.py
> new file mode 100755
> index 0000000000000..2b43adbbb4291
> --- /dev/null
> +++ b/tools/testing/selftests/userland/userland_test.py

[ ... ]

> +            with (
> +                self.closing_fd(rns.get_nsfd(CloneFlag.NEWNS)) as mntns_=
fd,
> +                self.closing_fd(rns.make_mount("tmpfs")) as rootfd,
> +            ):

[Severity: Low]
Will these parenthesized multi-item with-statements fail with a SyntaxError
on Python 3.9?  Parenthesized context managers across multiple clauses
require Python 3.10+, whereas Documentation/process/changes.rst specifies
Python 3.9.x as the minimum supported version.

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
Does check_child_src_slave_locking() leak a tmpfs mount over the host /tmp
when the test runs as root?

When os.geteuid() =3D=3D 0, enter_userns_if_unpriv() returns without unshar=
ing
CLONE_NEWUSER, so os.unshare(CloneFlag.NEWNS) keeps shared mount peer
groups with the host mount namespace.  Mounting tfd onto /tmp before
making mount propagation private propagates the tmpfs mount into the host
mount namespace, and cleanup only detaches /tmp/sub, leaving the host /tmp
masked after the test exits.  Calling Sys.set_mount_propagation("/") right
after os.unshare(CloneFlag.NEWNS), as check_standalone_mntns() does, would
prevent the mount from propagating to the host.

[ ... ]

> +            big_buf =3D ctypes.create_string_buffer(65536)
> +            with self.assertRaises(OSError) as cm:
> +                Sys.userns_set_idmap_raw(
> +                    userns_fd, ctypes.addressof(big_buf), size=3D65536
> +                )
> +            self.assertEqual(cm.exception.errno, errno.E2BIG)

[Severity: Medium]
Does this E2BIG check fail on kernels configured with 64 KiB (or 256 KiB)
base pages?

userns_set_idmap() returns -E2BIG only when size > PAGE_SIZE.  When
PAGE_SIZE >=3D 65536, size=3D65536 passes the PAGE_SIZE check and fails lat=
er
with EINVAL because the zeroed buffer has no extents.  Sizing the buffer
with os.sysconf("SC_PAGE_SIZE") + 1 would exceed PAGE_SIZE on all page
sizes.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261122193539.3334=
213-1-jarkko@kernel.org?part=3D25
