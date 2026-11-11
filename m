Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=27.86.113.4
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794379603;
	b=UjWNxVPVSw0e4RScQDWBpeoGsCqdMYoNorbb8t0MXYBgC08s2GxA11VYYmbAVjpfxOFA
	 aZCDvKfLhfqDokGEt9yuEbSEFty/3TCwBq9gIDzATwYEmarR80I/nPATDPRY6q4PZjb4W
	 GPEA8NxurlyylaF9d1nk3UQEE6E1owgzyI3KXcAI64PCMrjh0RH/WhCN4lK5u5du4lLPZ
	 qP5oH6agd7onq+wITzsJaRGsvVoxWZ0c4NYCh0a2CSPJ1U1EDv2FOqllFnhY78z5JXfIo
	 185sdTyOA/DIctd0U0pdx9DFN+Kgd9bwy0gngy4iPgDAuBI21tSZKL4lRqNPDRZ7e/g==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794379603;
	h=DMARC-Filter:Received:Message-ID:Subject:From:To:Date:Content-Type:
	 Content-Transfer-Encoding:User-Agent:MIME-Version:X-Biglobe-Sender:
	 DKIM-Signature;
	bh=uFcDDhURneTkoucrRv/+cXRAgeX4hejcf0akWIaCJEM=;
	b=J0VTFzdL6m4uE2nh6pDDuL66Y9YRgzBNcWV1aMihvxoTg48j+XK83yxAJP5PywRS/WPJ
	 onbR03sk3XPu31DK5IjHPbCk0C6Inm7uA+GpCKB05Sd0wVZM46BwsTighDYFbubK2LdCA
	 vN769AVVlIKOyQ09cAaIl8t0ICnijDMtGJiLmSQDLN/frDul38DA8t7IIoG0EqNrgQGpy
	 poNWqLF6ZinRVBkAn8nCHGJzVElOYl61hBOFr0Jrg6Ot/rUwdNsfElL0iNcAtoHbQa7Jd
	 dGGVRlA6RM6ePV1vk4aJcm3pwPhVbxxc1GWAmh9N309yk05iB979ziLL2TvadOKie+g==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=kjb.biglobe.ne.jp;
	spf=pass smtp.mailfrom=kjb.biglobe.ne.jp;
	dkim=pass header.d=kjb.biglobe.ne.jp header.i=@kjb.biglobe.ne.jp header.a=rsa-sha256 header.s=default-1th84yt82rvi header.b=PSiQG0mr;
	arc=none smtp.remote-ip=27.86.113.4
Received: from mta-snd-e04.biglobe.ne.jp (mta-snd-e04.biglobe.ne.jp [27.86.113.4])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (prime256v1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B6B2D606A31C
	for <linux-security-module@vger.kernel.org>; Wed, 11 Nov 2026 06:46:39 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org B6B2D606A31C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=kjb.biglobe.ne.jp
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kjb.biglobe.ne.jp
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kjb.biglobe.ne.jp header.i=@kjb.biglobe.ne.jp header.a=rsa-sha256 header.s=default-1th84yt82rvi header.b=PSiQG0mr
Received: from mail.biglobe.ne.jp by mta-snd-e04.biglobe.ne.jp with ESMTP
          id <20261111064632220.SUXG.68171.mail.biglobe.ne.jp@biglobe.ne.jp>;
          Wed, 11 Nov 2026 15:46:32 +0900
Message-ID: <3112e2ab6a83489fa82982253bf6779005d7b375.camel@kjb.biglobe.ne.jp>
Subject: RFC v3 Case Study Verification Results and Request for
 Reconsideration
From: Nakashima Seiichi <s-nakashima@kjb.biglobe.ne.jp>
To: kernel-hardening@lists.openwall.com, 
	linux-security-module@vger.kernel.org
Date: Wed, 11 Nov 2026 15:46:31 +0900
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.52.3-0ubuntu1.1 
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Post: <mailto:linux-security-module@vger.kernel.org>
List-Help: <mailto:linux-security-module+help@vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-security-module+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
X-Biglobe-Sender: s-nakashima@kjb.biglobe.ne.jp
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kjb.biglobe.ne.jp; s=default-1th84yt82rvi; t=1794379592;
 bh=uFcDDhURneTkoucrRv/+cXRAgeX4hejcf0akWIaCJEM=;
 h=Subject:From:To:Date;
 b=PSiQG0mrZJFZJBuIO0g8LOnAFOvUYx/KGEcdDCBWgTnJ2b+RELiTe83EX+9KFQsvfix2o5Hj
 GRy0zr6fi0pV0wmspL78u6s3Ya5fqEzMwofkDMybO715yGpmFACNEkWPJcymPX3dN+fhZI2oz+
 E2e9FS+U6dpwUYBaUMPGlDkABtc+s7wkJI4rmf8LY4H9G79lxmqbOjyh2FqZIL4OFTC4J1Yhth
 1sf/3L+hrdgvl1LKKDTuabWUDB8Fia+9qhfrytN8efYlWJt4s2Fp4AmF4m59ozq5FP3SLUla3l
 qkHWRTWYPimASKsmYkOY0Gi+2kB4GjTeVi7ao9dHps0T4+kA==

Dear ML,

Thank you for comments.

I actually tried creating the environment and running the case study,
but I realized it's quite difficult. Even just verifying this operation
was difficult for me alone, so I needed help from AI.

I would like to share the results of the RFC v3 case study verification
tests.
The test environment was Linux Mint 22.3 (based on Ubuntu 24.04 LTS)
with kernel 7.0.0-42-generic. The versions of the tools and libraries
used were as follows:

BPF LSM: enabled (bpf is present in the LSM list)
Tetragon: v1.1.0
seccomp-bpf: libseccomp 2.5.5

The target of the tests was CVE-2024-0582 (io_uring mitigation
techniques).
To get straight to the point, the assumptions we made in v3 turned out
to have many practical implementation difficulties, and I believe we
need to pause and reconsider our approach.
Specifically, the following points were identified:

1.BPF LSM-based blocking was not achievable on kernel 7.0.0 because the
io_uring-specific LSM hooks do not exist in this version. Detection is
possible, but blocking is not.

2.Tetragon v1.1.0 is incompatible with kernel 7.0.0 and failed at the
BPF object loading stage.

3.seccomp-bpf blocking was successful, but it is only effective on a
per-process basis.

4.During the tests, numerous implementation barriers were encountered,
including kernel symbol differences, missing tracepoint structures in
vmlinux.h, and bpftool virtual package issues.


Based on these results, the core claim of v3, that "it is technically
possible but not operationally scalable," was verified. However, the
effectiveness of BPF LSM and Tetragon depends heavily on the kernel and
tool versions, making practical deployment in the field difficult in
the current state.
I believe we should clarify the prerequisites and better define the
conditions for each technique before proceeding with further
discussion. I would appreciate your thoughts.

Best regards,

Nakashima Seiichi
