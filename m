Received: from outpost1.zedat.fu-berlin.de (outpost1.zedat.fu-berlin.de [130.133.4.66])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 773F72F3629;
	Tue, 18 Nov 2025 09:05:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=130.133.4.66
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763456704; cv=none; b=RdVS+Z1UgKHi5QyeNMWEhBDtoHn9tdhGN3Zp+LF1V0C5KujY53XBAzV0ycrtMvZGNLCgiJIaG423brm6AbbWd2/jPSz6QZyWpKvI7OmuFCOFTK1E2rUdJArSOXsPVi/s/FFaP2Jp5lgUH/AB5Aqtiy5EYNJi7xeLj8tnlOC+39c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763456704; c=relaxed/simple;
	bh=oTAojCy2hPmMHzAOkdawD6DewsGfTCJ/o0W46KMtvLY=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=qcpoLMiT/kwIDwpYmXu0dEA+m2NYx0oqr6su80N3WD37If08bgWV90gL+dYKhgxLTLhWDjYMzxRbiTVDbKX9BTTK/vLsJWyORKbuO7sXfMCMmtVs1mc6SctuJeUa1e2JSxpI+wIkmv060w4GBfdH7XBZqPxAQ/Nn3YqKnMpEQRk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=physik.fu-berlin.de; spf=pass smtp.mailfrom=zedat.fu-berlin.de; dkim=pass (2048-bit key) header.d=fu-berlin.de header.i=@fu-berlin.de header.b=DXZPaFNT; arc=none smtp.client-ip=130.133.4.66
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=physik.fu-berlin.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=zedat.fu-berlin.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fu-berlin.de header.i=@fu-berlin.de header.b="DXZPaFNT"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=fu-berlin.de; s=fub01; h=MIME-Version:Content-Transfer-Encoding:
	Content-Type:References:In-Reply-To:Date:Cc:To:From:Subject:Message-ID:From:
	Reply-To:Subject:Date:Message-ID:To:Cc:MIME-Version:Content-Type:
	Content-Transfer-Encoding:Content-ID:Content-Description:In-Reply-To:
	References; bh=c6fa7QJOnz8NJQgzl17rpisybY7idNpQfEsxCy9RvJA=; t=1763456701;
	x=1764061501; b=DXZPaFNTn+2Ijv7S0IREQIk/fpA3PR3eHZQdbPQ5ZGWAxR6XtuBMWcWEGTZBe
	DejYubSO88qqqXpubumoeUwJrJDXYULWfCX0QK2KHaZrj9ziV87/9s3emu9/nX5F60SInxpwf9nEY
	tMomDXKi7MzT2cvY9pFM8P6gKopGb7wI54xOdMaEbJpdhgbjYc9ERvLOle/gdNksaYYkhN02k4Myo
	repANiStpYRCfBFkKR/WhnrgH/d9JWCPJO5iyh8rVeNJtFZENW4Hvh98EagHOfE47LMDHxnp4aFS0
	vLcf94GXh0KP+HEYGv1PiZuU+vcjV5/EZQbNA6t6BDgowE0MnA==;
Received: from inpost2.zedat.fu-berlin.de ([130.133.4.69])
          by outpost.zedat.fu-berlin.de (Exim 4.98)
          with esmtps (TLS1.3)
          tls TLS_AES_256_GCM_SHA384
          (envelope-from <glaubitz@zedat.fu-berlin.de>)
          id 1vLHdz-000000028Hv-1ifL; Tue, 18 Nov 2025 10:04:59 +0100
Received: from p5b13aa34.dip0.t-ipconnect.de ([91.19.170.52] helo=[192.168.178.61])
          by inpost2.zedat.fu-berlin.de (Exim 4.98)
          with esmtpsa (TLS1.3)
          tls TLS_AES_256_GCM_SHA384
          (envelope-from <glaubitz@physik.fu-berlin.de>)
          id 1vLHdz-00000002TfY-0osH; Tue, 18 Nov 2025 10:04:59 +0100
Message-ID: <bc21bee14ca44077ae9323bfc251ad12390fa841.camel@physik.fu-berlin.de>
Subject: Re: [PATCH 0/2] apparmor unaligned memory fixes
From: John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>
To: deller@kernel.org, linux-kernel@vger.kernel.org,
 apparmor@lists.ubuntu.com,  John Johansen <john.johansen@canonical.com>,
 linux-security-module@vger.kernel.org
Cc: Helge Deller <deller@gmx.de>
Date: Tue, 18 Nov 2025 10:04:58 +0100
In-Reply-To: <20250531150822.135803-1-deller@kernel.org>
References: <20250531150822.135803-1-deller@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.58.1 
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Original-Sender: glaubitz@physik.fu-berlin.de
X-ZEDAT-Hint: PO

Hi Helge,

On Sat, 2025-05-31 at 17:08 +0200, deller@kernel.org wrote:
> From: Helge Deller <deller@gmx.de>
>=20
> Two patches which fix unaligned memory accesses in apparmor.
> Both triggered on the parisc platform, which is much more
> memory alignment sensitive and will report violations.
> Please check and apply.
>=20
> Helge
>=20
> Helge Deller (2):
>   apparmor: Fix 8-byte alignment for initial dfa blob streams
>   apparmor: Fix unaligned memory accesses in KUnit test
>=20
>  security/apparmor/lsm.c                | 4 ++--
>  security/apparmor/policy_unpack_test.c | 6 ++++--
>  2 files changed, 6 insertions(+), 4 deletions(-)

Thanks for looking into this!

Unfortunately, the problem still persists on SPARC even with v6.18-rc6:

[   76.209476] Kernel unaligned access at TPC[8dabfc] aa_dfa_unpack+0x3c/0x=
6e0
[   76.301115] Kernel unaligned access at TPC[8dac0c] aa_dfa_unpack+0x4c/0x=
6e0
[   76.392697] Kernel unaligned access at TPC[8dacf0] aa_dfa_unpack+0x130/0=
x6e0
[   76.485440] Kernel unaligned access at TPC[8dacf0] aa_dfa_unpack+0x130/0=
x6e0
[   76.578179] Kernel unaligned access at TPC[8dacf0] aa_dfa_unpack+0x130/0=
x6e0

I have documented the problem here [1].

So, I suspect that your fix is incomplete.

Adrian

> [1] https://github.com/sparclinux/issues/issues/30

--=20
 .''`.  John Paul Adrian Glaubitz
: :' :  Debian Developer
`. `'   Physicist
  `-    GPG: 62FF 8A75 84E0 2956 9546  0006 7426 3B37 F5B5 F913
