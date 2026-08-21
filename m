Received: from lamorak.hansenpartnership.com (lamorak.hansenpartnership.com [198.37.111.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0EE9D46A60A;
	Fri, 21 Aug 2026 09:12:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.37.111.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787303570; cv=none; b=uWBJWg5EiqgYHo0M9nNaBcnuS8Qordp18ChQ862hLnTa7cUb3L0ziQ5DFt2EY1SEinKvAOEPCjuI3d7+elkTidr7BbegOvyQKVvBRPih+Ro9erObjBxXjxH0bLJsEjQurTgOkrXw3AGBc1gU73OdL188hTXNXHfdoAliWScmMiw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787303570; c=relaxed/simple;
	bh=UvyO1Bp0j0IfstgH4vaO2FSNeM0F/X0sj4bue6iUzl0=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=mEmA/uvKBXcPy1LYiDGjeLHOJr3BeOr5VP/NLt2r8D9QtvqiqwCtltcoNOp5kdpBNSZCU1jKJXg0swD8EERdBJxFSkilZhYFkSpHtaycbiOC6v3DUatrmzSTMZJFHYoqN/RIcqVx+yXlEK9jutR6mxB1T9s3WFdrlaetup/bUKs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=HansenPartnership.com; spf=pass smtp.mailfrom=HansenPartnership.com; dkim=pass (1024-bit key) header.d=hansenpartnership.com header.i=@hansenpartnership.com header.b=N1ArxZlc; arc=none smtp.client-ip=198.37.111.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=HansenPartnership.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=HansenPartnership.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=hansenpartnership.com header.i=@hansenpartnership.com header.b="N1ArxZlc"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
	d=hansenpartnership.com; s=20151216; t=1787303550;
	bh=UvyO1Bp0j0IfstgH4vaO2FSNeM0F/X0sj4bue6iUzl0=;
	h=Message-ID:Subject:From:To:Date:In-Reply-To:References:From;
	b=N1ArxZlc7LqSiC51rJIheAukl0Sxdv6rOc4acoz1ZZN6oe1ZZAJD7W5qpZpq4AUf1
	 kOCss/5eDA93iDJkrSvOU3DMyykN3pT1mP1ixQidfz4YqsxKIcrPNu6BUA1oY03sJk
	 NEPkxEJFa1kpUQ7cvFFBZyNWasWU79so9kFrOi0g=
Received: from [IPv6:2a00:23c8:103c:f701:6906:2df:959d:44bf] (unknown [IPv6:2a00:23c8:103c:f701:6906:2df:959d:44bf])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519MLKEM768 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lamorak.hansenpartnership.com (Postfix) with ESMTPSA id 415CC1C032B;
	Fri, 21 Aug 2026 05:12:29 -0400 (EDT)
Message-ID: <b13a1741eceeba4d4ec50e1c898e011ea81a178b.camel@HansenPartnership.com>
Subject: Re: [RFC] IMA: periodic runtime re-measurement of process .text/GOT
From: James Bottomley <James.Bottomley@HansenPartnership.com>
To: Nicolai Kuntze <nicolai.kuntze@hs-mainz.de>, 
	linux-integrity@vger.kernel.org
Cc: Mimi Zohar <zohar@linux.ibm.com>, Roberto Sassu
 <roberto.sassu@huawei.com>,  Dmitry Kasatkin <dmitry.kasatkin@gmail.com>,
 Eric Snowberg <eric.snowberg@oracle.com>, Paul Moore	
 <paul@paul-moore.com>, James Morris <jmorris@namei.org>, "Serge E. Hallyn"	
 <serge@hallyn.com>, linux-security-module@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Date: Fri, 21 Aug 2026 10:12:27 +0100
In-Reply-To: <20260817102323.35950-1-nicolai.kuntze@hs-mainz.de>
References: <20260817102323.35950-1-nicolai.kuntze@hs-mainz.de>
Autocrypt: addr=James.Bottomley@HansenPartnership.com;
 keydata=mQENBE58FlABCADPM714lRLxGmba4JFjkocqpj1/6/Cx+IXezcS22azZetzCXDpm2MfNE
 lecY3qkFjfnoffQiw5rrOO0/oRSATOh8+2fmJ6el7naRbDuh+i8lVESfdlkoqX57H5R8h/UTIp6gn
 1mpNlxjQv6QSZbl551zQ1nmkSVRbA5TbEp4br5GZeJ58esmYDCBwxuFTsSsdzbOBNthLcudWpJZHU
 RfMc0ew24By1nldL9F37AktNcCipKpC2U0NtGlJjYPNSVXrCd1izxKmO7te7BLP+7B4DNj1VRnaf8
 X9+VIApCi/l4Kdx+ZR3aLTqSuNsIMmXUJ3T8JRl+ag7kby/KBp+0OpotABEBAAG0N0phbWVzIEJvd
 HRvbWxleSA8SmFtZXMuQm90dG9tbGV5QEhhbnNlblBhcnRuZXJzaGlwLmNvbT6JAVgEEwEIAEICGw
 MGCwkIBwMCBhUIAgkKCwQWAgMBAh4BAheAAhkBFiEE1WBuc8i0YnG+rZrfgUrkfCFIVNYFAml2ZBI
 FCS3GUMIACgkQgUrkfCFIVNZKjQf/deRzlXZClKxTC/Ee2yEPqqS7mm/INUA49KdQQ5oIhSxkUBy0
 9J4qjMIo5F8ZFkFTqikBqeL35LKu7O7rn8WETfX8Bxvos3HUsl3jHo34DES4MUFIpoQPgtiLRGwLb
 K0cVCAArR2u2qj4ABmTRrs1I1kvdjEw6gatOuXtEe/j5O2fvfzTq9GBr0Q3n2IAsFXi4hLlx6VPE8
 tyWUZ8BWJKtih3JAeUiXFvASL3McV0rV9RnU0VbjEQEhSE7PMYhWpnDC9AyBb0lXJllQRvC3NSkUB
 8KVQgNNxRPss0WE/nBoZ4dFA42jTyzTz8lNylxZoAWV7WJb3QxVg4oCodRVrxxrQhSmFtZXMgQm90
 dG9tbGV5IDxqZWpiQGtlcm5lbC5vcmc+iQFVBBMBCAA/AhsDBgsJCAcDAgYVCAIJCgsEFgIDAQIeA
 QIXgBYhBNVgbnPItGJxvq2a34FK5HwhSFTWBQJgS5mYBQkbNYS9AAoJEIFK5HwhSFTWBpwIAL5Bk3
 5FB34U6iHmDzzgdCbxLTs43T/YQyJpcGIvopBvnI/fDY8oSG6Df64/O6B+1R+A8TDp6ZG5ysUWnCC
 6GuIaEHemBYkitMPglR6+sGCMQY7O0mlsPvdssvKK1KI9Bno4VU6ogaF2qVzefSqg1Djmf/DcsxWP
 rI/jdJ8FB5AYR2rjIdDFc+zRdAJuavo1/anyY2wgpFh/3R8IOYAEfWV9nGgYkf9+tA4EIn1sxE0I3
 L5oW2N3mbyRrkzuBwO8ztMCwqEPk7moWzhokcZqMXiAIahaZdkashJC+s2X2RZSGCy+g+pvY5NN4B
 BVG5XwLgVBqbHMTcxE0fbmPqz+q6O0LEphbWVzIEJvdHRvbWxleSA8amVqYkBoYW5zZW5wYXJ0bmV
 yc2hpcC5jb20+iQFXBBMBCABBFiEE1WBuc8i0YnG+rZrfgUrkfCFIVNYFAmODZ5ACGwMFCRs1hL0F
 CwkIBwICIgIGFQoJCAsCBBYCAwECHgcCF4AACgkQgUrkfCFIVNZu0Af/TzvL2/NdgAcw9uN3x60H8
 jc4QUq14VpxcFEFEMpcj1morkX/G93V+56HBBaXZj+yK8PhxIA/SIz+sU7C/0YvKuvzakP8ZX/7WJ
 e32SOUtjfr/VTaqjIBzNj6OxLvZpmNbBw7s6DwhhNpHOWqJ/1ml+PtDRDV71IB58yVqQjp1xlNKVl
 ZppcJ5908EJzsFnRIVjiQiDSKoppqB2BCibBbrWcln7CiWMyOC/cco6SIn6twH+f7+aivJ3xGcOE2
 a9gBKF5rNi9TBoX9oyPmshv/TDmnohsVrH7AYXlGYfZTk15SWEiROh1QX8/uD9wl/gcIv5EDUpT/F
 L2jzOsA5663bw==
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.56.2 
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Mon, 2026-08-17 at 12:23 +0200, Nicolai Kuntze wrote:
> Hi,
>=20
> This is a design RFC, not a patch submission -- I'd like feedback on
> the approach before polishing the patch series further. A working
> reference implementation exists today for demonstration; details and
> links below.
>=20
> Problem
>=20
> Every existing IMA hook (FILE_CHECK, MMAP_CHECK, BPRM_CHECK,
> MODULE_CHECK, ...) measures once, at load time: file open, exec,
> mmap, module load, or an explicit ima_measure_critical_data() call.
> Nothing in IMA today re-measures an object after it's already
> resident. A process's .text

A processes text segment is mapped ro and cannot change.  We're looking
to apply the kernel ROX guarantees to user processes, which would make
it very hard even for someone with privilege to modify the text
segment, but if you're looking to fix something like the copy fail
cache corruption, then a strengthened ROX mechanism would be way better
than trying to detect it.

>  or GOT can be modified in memory after load

The GOT (and GOT.PLT) sections are updated by the dynamic linker
*after* the binary is measured.  They're also often constructed lazily
by just in time symbol resolution meaning they change throughout the
lifetime of the process ... therefore if you include them, practically
every measurement will be different and there'll be no way to
reconstruct what measurement you should have seen or relate it back to
the original measurement.  It is possible to do non-lazy linking and
then seal the GOT read only, but that incurs a huge startup cost, so
what is the actual threat model here?

>  (ptrace(), a kernel exploit writing through /proc/pid/mem, or
> similar) without IMA ever re-examining it

Those are all privileged operations, so what is the threat model you're
guarding against?  because if it's something like container mutations,
then using dm-verity and proper ROX handling is likely a better
guarantor.

Regards,

James
