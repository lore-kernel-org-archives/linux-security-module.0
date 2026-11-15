Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794751940;
	b=UDIXWkIr9pIRoz0uNQTLs6zG013I/2JdTMX9blpyCH9UK5/MQD7Nwr8sk/3WGuoSGsKv
	 S7TRi81I/mPlYiWf1MwVBP/UNuQwv/rKNOdWu0FDIebbx5Okm94wqNkNBrfUhnnSa9PMN
	 QQcVBgGvqNKXJdT+ES3BldWnVjSUFL1gGW7hC+ks586CBQDvxmGwRxULnUWn0iWQjkqRB
	 kS3mf8DpLgMPND59qUPxHBXHvIoiO/TXlIOumxqzlFJ2z8a5Yq74Khl7e2zUgP4Df+F2f
	 Ybh8I5NEqzY99H0C2Bcha1U0LPqIbIpAboq0pt1K/DXIIjq9/Fe61H9bCfL5RuchxUw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794751940;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=PqTvsFh1n3PsgpBOBeO8vvJTpVAiC4pJspCQxkeW7c8=;
	b=k+3uqw9laSLzU7q6cObiwesTRq3m5tpf5kJQ1wvQ9neR2PB+LzdjVR65mcvOefkHXqmO
	 pFHRUBx9wf0NvGP2xksqgE7Zi+Q3qAi+yBxZXIW1cfcmYEgdUdALhcnJUtAInNnv0dUTS
	 30wQlmykekllqiimwWmu1M8QywrNBUy3NU0v7S4bRKgodjQrOMYYrYb214KeJYddHXByd
	 sdmSPd4McKdMrgXCzyVmEs7TdJiZ0SKKzp193iXNomHxqwAMI6duk3H9l2M8hB896i3y9
	 trv8qOXyEgz2cvUZlBhniaI2Ktuw1VKGLO0WIiawUdDG+/Trr/CXadhJiX4sQqhRIuw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=DT8U9KOL;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 88DE1606A31A
	for <linux-security-module@vger.kernel.org>; Sun, 15 Nov 2026 14:12:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=DT8U9KOL
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 46F971F000C4
	for <linux-security-module@vger.kernel.org>; Sun, 15 Nov 2026 14:12:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794751940;
	bh=PqTvsFh1n3PsgpBOBeO8vvJTpVAiC4pJspCQxkeW7c8=;
	h=From:Subject:Reply-To:Cc:In-Reply-To:References:Date;
	b=DT8U9KOL7XCjUqtHQxOQtAlnZF0hqDkBbPFeXIJ/txU9U4a21oN7NCDIyrgTVsGK9
	 pzdyKku0D6OoudSpdiLzey7Jq5agOFHQ9ZfrkEvmd5XxA8nLyQkMW5dSUNZ6kjKxi/
	 ENT+e0XwFZIPk0zMfY78B/XVqTU2qc18jFFyXflCuRWbP/BfamWFGUhRNepm/3n5Q0
	 zTg7ATPHryOpOK8uzOSfmeEmYdraurN5g5GH8eqGla3o9ZU7R1g33tcoZR7QSVJ6T+
	 oeLYmEJnuGx3Mbl7IpjMxy8JUG/StiobYgXZc8KhKZihihqc27WNg+KE/WOs8wiMEl
	 Jks44EEi6jI0Q==
Message-ID: <sashiko-outbox-215570@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 13/13] selftests/bpf: add uprobe_multi test on overlayfs
 without data
Reply-To: sashiko-reviews@lists.linux.dev
Cc: linux-security-module@vger.kernel.org
In-Reply-To: <20261115-work-ovl-d_real-v1-13-ca155efbcb2e@kernel.org>
References: <20261115-work-ovl-d_real-v1-0-ca155efbcb2e@kernel.org>
 <20261115-work-ovl-d_real-v1-13-ca155efbcb2e@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sun, 15 Nov 2026 14:12:19 +0000
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Post: <mailto:linux-security-module@vger.kernel.org>
List-Help: <mailto:linux-security-module+help@vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-security-module+owner@vger.kernel.org>
Precedence: list

> Add a uprobe_multi test that attaches to a metacopy file on overlayfs
> whose redirect into a data-only layer points at nothing:
>=20
> - the overlayfs is set up in a child in its own mount namespace
>=20
> - BPF_LINK_CREATE must fail with ENOENT from the lazy lowerdata lookup
>=20
> - skip if overlayfs with data-only layers isn't available
>=20
> Before d_real() could fail this got an EIO from uprobe_register().
>=20
> Signed-off-by: Christian Brauner (Amutable) <brauner@kernel.org>

Sashiko has reviewed this patch and found no issues.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261115-work-ovl-d=
_real-v1-0-ca155efbcb2e@kernel.org?part=3D13

