Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793823314;
	b=dC0UC49UeN3uJOFezOPhk9AxABlrE4TURKdd9ICdFdixeyRU6hwZn+/vdW5BBxVY+Ac+
	 d60t0Jn3Ni0RxO/VlnaHm8u0ugKrmgNe2mpaAb19ywzb+KgEm00Yr6E1ZkTEmfSNQmjSj
	 Sx9Lo7SHbMyNObh7x6tb14oZuwFzEDhq1Fj3a8bqU+McTvTMt3WU4EdQVxvVUcfe9lE4i
	 lp6/Wuq3TPTbCDeD/Mv04nmsfhp+pUMYnpasZeJDunopKIjD8lSmFdAYDYTUaKYcfZPnl
	 XY2Y/KyrCqVJzLjNfureDvx5Dl8UmiJlbx8NzGp9Dw+H/YV1z13HAXsobpqkd10ad0A==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793823314;
	h=Received:DKIM-Signature:Received:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Received:MIME-Version:References:In-Reply-To:
	 From:Date:X-Gmail-Original-Message-ID:X-Gm-Features:Message-ID:
	 Subject:To:Cc:Content-Type:Content-Transfer-Encoding;
	bh=5hs0yObu632v5VqYscPdHVqsnq/hS9vQJRHPhHsRg0A=;
	b=vCvUKt3wKTbo6cV1M2cf6XMbrlUFAYpunP1bWdmP/R8fLNq3sX667DG60YRxoqfxJEeH
	 zZEmFHd7oZOaSDfFKwMgb0tdnvUcWwpk7q2axF0cFb3L6bRxJPUl3bsNglKVqNUG+kLP/
	 uTQMtGf0NjcCyD3Cxb/ZviuSpknLzvXCzehABlPouojiB/HAWBKccQr7z91csfCb/ft1T
	 IFumbb3FvN+4zYrie03Z2B3mARSslX/fpUhLHGkhHcG0eL6xyo0iU0brLnFk2qZAuh4Kn
	 1t/KnRcgB9ytdDabnfUpVhc70Nc/K7ZmLLhR0JvHZAOiWzOx1V17flqVU7E3zHpC5Mw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=jntMCYXR;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9337A60B9095
	for <linux-security-module@vger.kernel.org>; Wed,  4 Nov 2026 20:15:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=jntMCYXR
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3B26A1F00919
	for <linux-security-module@vger.kernel.org>; Wed,  4 Nov 2026 20:15:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793823309;
	bh=5hs0yObu632v5VqYscPdHVqsnq/hS9vQJRHPhHsRg0A=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc;
	b=jntMCYXR3W1rZcXXXOFyG8UkNWM1zptt1zDKpmY/3jOcAGPvEuxMZ+WffuO6qEarm
	 RXltF/saZTDN+mSpF4Y1fRmkhNqU68n+uDYsM5u8Uxhwl3OzxfHw4Awgfj5xG6FU7q
	 Pesy/LAyU3SBa0H5DOvWI3fCmCYEqW3STMLi3qhAvI7uUPzTSiLXnXdX/WugJ/AVZc
	 1f47yXHjQONASzabXPWHALxSYWAPGhuwxS6dBRcVA8+bydeoc7pZHOe6Uv0AOjHhKS
	 zmC7LE+jcSa1XJlUPNCb2vcqyizu64WLFSjJ5U9OEYxoih8QjYWD1u2EYn474vwuoO
	 vK8x8ON4bKLFg==
Received: by mail-dl1-f41.google.com with SMTP id a92af1059eb24-15dd124bbe7so2280829c88.1
        for <linux-security-module@vger.kernel.org>; Wed, 04 Nov 2026 12:15:09 -0800 (PST)
X-Forwarded-Encrypted: i=1; AKwUvBz/Y/ftmE+CV18aHQ4nD2dzPxg+etfoOfyskX1dV4HWN2v+I4EBaDOcxD122X9ihUjnAmLfoNt3rrRY12rGPlVSSsLpLnk=@vger.kernel.org
X-Gm-Message-State: APuU4Z/pXbdnF5gpuHaxu/V/nfSwqS0cxsVhXi665vLrp4GraO4tAtxM
	ZDZ1QjWBL6U4xG0CfRt5FRyTjnTPX5tnQB6hcaoCtc+PZCH9mz20fqkpZWXIWqzn08fo6cjX5Af
	6K1ZuneLI9R4GElDzEYbdRkB7o0d4Pk4=
X-Received: by 2002:a05:7022:5f0b:b0:1ab:de8b:5f0f with SMTP id
 a92af1059eb24-1ac5cb18717mr23723691c88.40.1793823308323; Wed, 04 Nov 2026
 12:15:08 -0800 (PST)
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Post: <mailto:linux-security-module@vger.kernel.org>
List-Help: <mailto:linux-security-module+help@vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-security-module+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <20261029-b4-ipe-keyring-rfc-v2-0-77727b205844@nvidia.com> <20261029-b4-ipe-keyring-rfc-v2-1-77727b205844@nvidia.com>
In-Reply-To: <20261029-b4-ipe-keyring-rfc-v2-1-77727b205844@nvidia.com>
From: Fan Wu <wufan@kernel.org>
Date: Wed, 4 Nov 2026 12:14:57 -0800
X-Gmail-Original-Message-ID: <CAKtyLkHtZeToq7YN7n2jffK0DmR7Axu3cQ+Kac_+RYvtsF=+cw@mail.gmail.com>
X-Gm-Features: AclHuK825M3Tp0Q3mYcH1rJyDUZVk5uCyEMH07CZFl9zj20qOO90PZscL7Din2Q
Message-ID: <CAKtyLkHtZeToq7YN7n2jffK0DmR7Axu3cQ+Kac_+RYvtsF=+cw@mail.gmail.com>
Subject: Re: [PATCH v2 1/3] ipe: add the .ipe policy keyring
To: manuelh@nvidia.com
Cc: Fan Wu <wufan@kernel.org>, David Howells <dhowells@redhat.com>, 
	Jarkko Sakkinen <jarkko@kernel.org>, Christian Brauner <brauner@kernel.org>, 
	Andrew Halaney <andrew@amutable.com>, Paul Moore <paul@paul-moore.com>, 
	James Morris <jmorris@namei.org>, "Serge E. Hallyn" <serge@hallyn.com>, Jonathan Corbet <corbet@lwn.net>, 
	Shuah Khan <skhan@linuxfoundation.org>, Randy Dunlap <rdunlap@infradead.org>, 
	Luca Boccassi <luca.boccassi@gmail.com>, 
	James Bottomley <James.Bottomley@hansenpartnership.com>, 
	linux-security-module@vger.kernel.org, keyrings@vger.kernel.org, 
	linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org, 
	kexec@lists.infradead.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Oct 28, 2026 at 5:31=E2=80=AFPM Manuel Huber via B4 Relay
<devnull+manuelh.nvidia.com@kernel.org> wrote:
>
> From: Manuel Huber <manuelh@nvidia.com>
>
> Add a dedicated .ipe keyring for IPE policy signature verification.
> With this, userspace can provision its own keys into the keyring,
> then restrict it and activate it for IPE policy signature verification.
>
> Gate creation of the keyring behind a new by-default disabled
> CONFIG_SECURITY_IPE_KEYRING Kconfig option. When created, the keyring
> is empty and writable. The keyring is used as a fallback after the
> existing policy trust sources only when it is created, non-empty, and
> restricted with restrict_link_reject.
>
> This enables scenarios in which a trusted userspace component generates
> an IPE policy, and creates an ephemeral policy-signing key pair,
> provisions its public certificate, and restricts the IPE keyring during
> the early lifetime of a system. The trusted component can then sign the
> IPE policy, destroy the private key, and load and activate the policy.
> During that phase, the system is considered in a trusted state whereas
> the system transitions into a possibly untrusted state afterwards,
> running arbitrary user-provided applications. In such a scenario, the
> trusted userspace component could reside on a dm-verity protected
> rootfs disk, and applications would reside on additional dm-verity
> protected disks. The latter disks would be dynamically attached and
> their dm-verity root hashes and/or signatures not known a priori to
> launching the system.
>
> A concrete usage scenario could be Kata Containers, which enables
> running Kubernetes pods in ephemeral, headless utility VMs, possibly
> without systemd. The rootfs disk is static and known beforehand, but
> containerd's image layers might be acquired and transported into the
> VM using the erofs snapshotter and dynamic block device attachment
> using dm-verity. While in that usage scenario, signing a per-guest
> policy with a pre-provisioned policy-signing certificate in the
> builtin, secondary, or platform keyrings would be technically possible,
> it would require including its corresponding private key in the guest
> build artifacts. Making it possible to use an ephemeral,
> userspace-provided key avoids shipping a static policy-signing private
> key with the guest rootfs.
>

Reading through this scenario again, I have a question about the design.

I suspect the reason you need a signing key inside the guest rootfs is
that you are running the snapshotter inside the VM. Have you
considered generating the snapshots on the VM host, signing the policy
there, and passing it into the guest?

The workflow would be:

1. The host generates an ephemeral signing key pair for the VM and
injects the public certificate into the guest's platform keyring via
firmware.
2. The host prepares the image snapshots, computes their dm-verity
root hashes, and signs the resulting IPE policy which allows execution
by dm-verity root hash with the ephemeral private key.
3. The host attaches the snapshot block devices and passes the signed
policy into the guest, where the guest simply loads and activates it
against .platform.

That way no private key ever needs to live in the guest, and it
confines the TCB to the VM host. Would this approach work for your
setup?

Fan
