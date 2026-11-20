Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795214697;
	b=k55IUbyuXqz5Z6wJAl07DlWVQqjvY0IC+CfITORogde3WTmdC9GHY+yM/GH+ryncKMC/
	 kCF/sMZSjisbLVHHUXP5Kp/Sk6Ix3D5WoL9ZOC7kMCHqsWyhoJV4u9NsBPnI9YspUisUq
	 M/dk5k1ciP94jU5LFVwOS5nJxYy/JZlqDjSYqI3UoV42qs/wz7E1or/mJ75xUt4K5tzaO
	 eVtYpBxb5ycd82KuAw1XFTKrT3z2beL2JMxPPeU4ytnihq3duGqPrmeRDjbMrXyHvNnb2
	 JNZ0ln5LbqorZuTUpo6kpGbu8jtILxEqGpQfkZvLtNX5M4gRHKNcwbCCH2dYnQhyHbg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795214697;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=p2Lf6qpcYVJhQ5+q/779aR/iL3yLTW5qgQJ75weSGn4=;
	b=hG21ps0OshoInEDU7soLfE+Dw4AWZc1NrzKUxNhF1hiCaUeKkebPOgdoLTmKAnsQ3F6m
	 XQ5R2UT62lA+J8qcpSLM/T3MTWH5RdzjurAI69JXGzrURS1f5GqirZ2EWMVWX868r8HQ/
	 eNWwuPjY+6MFgIzx912HFD2dACgLwVJx06fVM6dd+g3C+YRmIkDzldTko2R5F/fNQYTAw
	 62/qHkdH/yA48dgl9aphW4Fp+APM7xpQRYmgEosS+tkoz1eBvdp/05YGyCZPR2WrHHIK3
	 +Gsvehme4eJSoAQlzskCM6tUERH3ovH4zIg12z5HBo8wv1mrieUgFjejtU3RFUwjFwA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=VS5VVo7j;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C8B4F606A684
	for <linux-security-module@vger.kernel.org>; Fri, 20 Nov 2026 22:44:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=VS5VVo7j
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D168D1F000E0;
	Fri, 20 Nov 2026 22:44:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795214697;
	bh=p2Lf6qpcYVJhQ5+q/779aR/iL3yLTW5qgQJ75weSGn4=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=VS5VVo7jR8o9HFGRVBMaebXWwvuWWI8YlUW/45Fk+GzxPhR5b82izYDOtFYH74FD4
	 FkZtvDm5bTTPH1SyT+RSOm8jKHjtbdUmYWtBlCMGw4La2B3p1phgsBE4IW6yM9E2kv
	 lqjxol/m+d7i9nSgiQBtoklLVYGFMrdxr9HiIQXEPW8HXqkbEmmJWKtu8Avuu4nkZz
	 eJWeN1lEqr5xxU+JwV78FwX9nlLAaTRnEy3gP+htbeWSa3b/Vzfn+3ALeMpuMnN0R5
	 uRP+RCU2x26NhQtg/3FHhW5NOh1eb50DR3FJem32SfLytVRCzBMlAEVWzwF2iPwFXM
	 OszCw/wOYPplQ==
Message-ID: <sashiko-outbox-226305@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [RFC PATCH v4 13/14] selftests/rootns: Add root namespace test
 suite
Reply-To: sashiko-reviews@lists.linux.dev
To: "Jarkko Sakkinen" <jarkko@kernel.org>
Cc: linux-mm@kvack.org, linux-security-module@vger.kernel.org, "Albert Ou" <aou@eecs.berkeley.edu>, "Alexander
 Gordeev" <agordeev@linux.ibm.com>, "Alexander Viro" <viro@zeniv.linux.org.uk>, "Alexandre
 Ghiti" <alex@ghiti.fr>, "Andreas Larsson" <andreas@gaisler.com>, "Andrew
 Morton" <akpm@linux-foundation.org>, "Andy Lutomirski" <luto@amacapital.net>, "Andy
 Lutomirski" <luto@kernel.org>, "Anna-Maria Behnsen" <anna-maria@linutronix.de>, "Arnd
 Bergmann" <arnd@arndb.de>, "Ben Segall" <bsegall@google.com>, "Borislav
 Petkov" <bp@alien8.de>, "Casey Schaufler" <casey@schaufler-ca.com>, "Catalin
 Marinas" <catalin.marinas@arm.com>, "Christian Borntraeger" <borntraeger@linux.ibm.com>, "Christian
 Brauner" <brauner@kernel.org>, =?utf-8?b?Q2hyaXN0b3BoZSBMZXJveSAoQ1Mg?=
 =?utf-8?b?R1JPVVAp?= <chleroy@kernel.org>, "Chris Zankel" <chris@zankel.net>, "Dave
 Hansen" <dave.hansen@linux.intel.com>, "David Hildenbrand" <david@kernel.org>, "David
 Howells" <dhowells@redhat.com>, "Davidlohr Bueso" <dave@stgolabs.net>, "David
 S. Miller" <davem@davemloft.net>, "Dietmar Eggemann" <dietmar.eggemann@arm.com>, "Frederic
 Weisbecker" <frederic@kernel.org>, "Geert Uytterhoeven" <geert@linux-m68k.org>, "Hallgrimur
 H. Gunnarsson" <halg@google.com>, "Heiko Carstens" <hca@linux.ibm.com>, "Helge
 Deller" <deller@gmx.de>, "H. Peter Anvin" <hpa@zytor.com>, "Ingo Molnar" <mingo@redhat.com>, "James
 E.J. Bottomley" <James.Bottomley@HansenPartnership.com>, "Jan Kara" <jack@suse.cz>, "John
 Johansen" <john.johansen@canonical.com>, "John Paul Adrian Glaubitz" <glaubitz@physik.fu-berlin.de>, "Jonathan
 Corbet" <corbet@lwn.net>, "Josef Bacik" <josef@toxicpanda.com>, "Juri Lelli" <juri.lelli@redhat.com>, "Kees
 Cook" <kees@kernel.org>, "K Prateek Nayak" <kprateek.nayak@amd.com>, "Liam
 R. Howlett" <liam@infradead.org>, "Lorenzo Stoakes" <ljs@kernel.org>, "Madhavan
 Srinivasan" <maddy@linux.ibm.com>, "Magnus Lindholm" <linmag7@gmail.com>, "Manfred
 Spraul" <manfred@colorfullife.com>, "Mark Rutland" <mark.rutland@arm.com>, "Matt
 Turner" <mattst88@gmail.com>, "Max Filippov" <jcmvbkbc@gmail.com>, "Mel
 Gorman" <mgorman@suse.de>, "Michael Ellerman" <mpe@ellerman.id.au>, "Michal
 Hocko" <mhocko@suse.com>, "Michal Simek" <monstr@monstr.eu>, "Mike Rapoport" <rppt@kernel.org>, "Neal
 Gompa" <neal@gompa.dev>, "Nicholas Piggin" <npiggin@gmail.com>, "Palmer
 Dabbelt" <palmer@dabbelt.com>, "Paul Moore" <paul@paul-moore.com>, "Paul
 Walmsley" <pjw@kernel.org>, "Pavel Tikhomirov" <ptikhomirov@virtuozzo.com>, "Peter
 Zijlstra" <peterz@infradead.org>, "Randy Dunlap" <rdunlap@infradead.org>, "Richard
 Henderson" <richard.henderson@linaro.org>, "Rich Felker" <dalias@libc.org>,
 =?utf-8?b?Uml0ZXNoIEhhcmphbmkgKElCTSk=?= <ritesh.list@gmail.com>, "Russell
 King" <linux@armlinux.org.uk>, "Serge Hallyn" <sergeh@kernel.org>, "Shrikanth
 Hegde" <sshegde@linux.ibm.com>, "Shuah Khan" <skhan@linuxfoundation.org>, "Steven
 Rostedt" <rostedt@goodmis.org>, "Suren Baghdasaryan" <surenb@google.com>, "Sven
 Schnelle" <svens@linux.ibm.com>, "Thomas Bogendoerfer" <tsbogend@alpha.franken.de>, "Thomas
 Gleixner" <tglx@kernel.org>, "Valentin Schneider" <vschneid@redhat.com>, "Vasily
 Gorbik" <gor@linux.ibm.com>, "Vincent Guittot" <vincent.guittot@linaro.org>, "Vincenzo
 Frascino" <vincenzo.frascino@arm.com>, "Vlastimil Babka" <vbabka@kernel.org>, "Will
 Deacon" <will@kernel.org>, "Yoshinori Sato" <ysato@users.sourceforge.jp>, "Zygmunt
 Krynicki" <zygmunt.krynicki@canonical.com>
In-Reply-To: <20261119224312.1037966-14-jarkko@kernel.org>
References: <20261119224312.1037966-1-jarkko@kernel.org>
 <20261119224312.1037966-14-jarkko@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 20 Nov 2026 22:44:52 +0000
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
- [Medium] selftests/rootns: wrong _IOC_NONE direction in _io() on
  wide-ioc archs
- [Low] selftests/rootns: non-blocking accepted socket in
  CellService._on_accept()
- [Low] selftests/rootns: resource leaks on Cell init and test setUp()
  failures
--

commit 646cdbb1cf35062e2a914f151927bb968fe747a7
Author: Jarkko Sakkinen <jarkko@kernel.org>

selftests/rootns: Add root namespace test suite

This commit adds a kselftest suite for the rootns and mount-namespace
configuration uAPI, covering privileged, unprivileged, and edge-case
scenarios.

> diff --git a/tools/testing/selftests/rootns/rootns_cells.py b/tools/testi=
ng/selftests/rootns/rootns_cells.py
> new file mode 100755
> index 0000000000000..b690ed71a5211
> --- /dev/null
> +++ b/tools/testing/selftests/rootns/rootns_cells.py

[ ... ]

> +def _io(magic: int, nr: int) -> int:
> +    return _ioc(0, magic, nr, 0)
> +
> +
> +def _iowr(magic: int, nr: int, size: int) -> int:
> +    rw =3D 6 if _is_wide_ioc_arch() else 3
> +    return _ioc(rw, magic, nr, size)

[Severity: Medium]
Should _io() pass direction 1 instead of 0 when _is_wide_ioc_arch() is
True?

On PowerPC, SPARC, Alpha, and MIPS, _IOC_NONE is 1U rather than 0U, so
_IO() sets bit 29.  Passing 0 encodes the wrong ioctl numbers for
ROOTNS_GET_NSFD, ROOTNS_KILL, and NS_GET_*, causing the kernel to reject
them with ENOTTY.

[ ... ]

> +@dataclass
> +class Cell:
> +    name: str
> +    flags: int =3D ROOTNS_KILL_ON_CLOSE | ROOTNS_CLOSE_ON_EXEC
> +    cfd: int =3D field(init=3DFalse, default=3D-1)
> +    mntns_fd: int =3D field(init=3DFalse, default=3D-1)
> +    root_dfd: int =3D field(init=3DFalse, default=3D-1)
> +    init_pid: int | None =3D field(init=3DFalse, default=3DNone)
> +    exit_status: int | None =3D field(init=3DFalse, default=3DNone)
> +
> +    def __post_init__(self) -> None:
> +        self.cfd =3D rootns(self.flags)
> +        self.mntns_fd =3D rootns_get_nsfd(self.cfd, CLONE_NEWNS)

[Severity: Low]
Does Cell.__post_init__() leak self.cfd and the namespaces it pins if
rootns_get_nsfd() raises OSError?

Similarly, in rootns_test.py, unittest does not run tearDown() when
setUp() fails or raises an exception, so CellServiceTest.setUp() leaks
self.daemon_pid and self.tmpdir if the daemon readiness loop calls
self.fail(), and RootnsUapiTest.setUp() leaks self.cell's file descriptors
if setup_rootfs() fails.

[ ... ]

> +class CellService:
> +    def __init__(self, sock_path: str) -> None:

[ ... ]

> +        self.srv.setblocking(False)
> +        self.sel.register(self.srv, selectors.EVENT_READ, self._on_accep=
t)

[ ... ]

> +    def _on_accept(self) -> None:
> +        conn, _ =3D self.srv.accept()
> +        with conn:
> +            data =3D b""
> +            while not data.endswith(b"\n"):
> +                chunk =3D conn.recv(4096)
> +                if not chunk:
> +                    break
> +                data +=3D chunk

[Severity: Low]
Can conn.recv(4096) raise an uncaught BlockingIOError here?

In Python, socket.accept() on a non-blocking listening socket returns a
non-blocking client socket.  If _on_accept() runs after connect() wakes the
listening socket but before the client sends its request line, conn.recv()
fails with EAGAIN and crashes serve_forever() unless conn.setblocking(True)
is called first.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261119224312.1037=
966-1-jarkko@kernel.org?part=3D13
