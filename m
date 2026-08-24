Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B2E0641F345;
	Mon, 24 Aug 2026 13:17:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787577473; cv=none; b=KtNajm3/PQ2S7VkI1+hL1FFd/rUGZn1ha0ROEREsPNwu4VHnpthyOSeOBzNYMJITfbN07CF23UG3cucQjwFSt/F5t840kPzsk7eqjtjpkCKUnaCGCJ2EUFvS0KhQXCE4emqUIGpQgPYsKxBT+2WUCT2CQyQHMdsb5vY9qCs7HiA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787577473; c=relaxed/simple;
	bh=5Hn1TQP/ACq4whtIBZ2GE8JrqMfOQKWgVmzZDilbU0M=;
	h=Message-ID:Subject:From:To:Cc:In-Reply-To:References:Content-Type:
	 Date:MIME-Version; b=ifvsreh3m1Feq39prMXKS6AHx4wGr8Za0giBm6tCnT4Gq3s3K62iNQmBcpp1HEo4eFaH50tpZijqJO1x1HeRjocFg2ezrymk4LHKnMQjuAb9k7RjSYuHa7c7lhxsYYor/DktK4QObhl+zY8NtDTCt7xPcedQcD1K57iKLkUqdxU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=lq4AQVDG; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="lq4AQVDG"
Received: from pps.filterd (m0356517.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 67OD1XgP1957979;
	Mon, 24 Aug 2026 13:17:29 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=5Hn1TQ
	P/ACq4whtIBZ2GE8JrqMfOQKWgVmzZDilbU0M=; b=lq4AQVDGxhnR/1pFDtmtav
	d/2MXfg1DT4JO6e1C9K13SHJA7GPZ8bYnLVnCHViFHj/sEl5LBUEjhNr+MTWGI2v
	xo36iTsngiEc258V0KKVzdDRzOKifeqt19PODd651MoRDMGCOneBPDVzq72Z73+M
	jLls94XAIRDdOJ+8WxDD1gXOuZxj2+D1RRHXWqnhNT4CivYZm++L9vLfynS8XVu9
	sp8njC2PEFfocLz3euJkKqFJeZmu4YMJVvHewW0j6gsbbk26UiEj5JWqNGHiwkrt
	WfCiJ5OCMYSOYQ3YQZfjpDzkW1zXEmoQgxbTd8E4PDM/xOtpY3ZwMTLuPCE0S/Tw
	==
Received: from ppma21.wdc07v.mail.ibm.com (5b.69.3da9.ip4.static.sl-reverse.com [169.61.105.91])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4g73g4hg4a-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 24 Aug 2026 13:17:28 +0000 (GMT)
Received: from pps.filterd (ppma21.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma21.wdc07v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 67ODBGpA024964;
	Mon, 24 Aug 2026 13:17:27 GMT
Received: from smtprelay01.wdc07v.mail.ibm.com ([172.16.1.68])
	by ppma21.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4g7q3jp30j-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 24 Aug 2026 13:17:27 +0000 (GMT)
Received: from smtpav02.wdc07v.mail.ibm.com (smtpav02.wdc07v.mail.ibm.com [10.39.53.229])
	by smtprelay01.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 67ODHR9748300352
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 24 Aug 2026 13:17:27 GMT
Received: from smtpav02.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 57C285805C;
	Mon, 24 Aug 2026 13:17:27 +0000 (GMT)
Received: from smtpav02.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 507115805F;
	Mon, 24 Aug 2026 13:17:26 +0000 (GMT)
Received: from li-43857255-d5e6-4659-90f1-fc5cee4750ad.ibm.com (unknown [9.61.146.167])
	by smtpav02.wdc07v.mail.ibm.com (Postfix) with ESMTP;
	Mon, 24 Aug 2026 13:17:26 +0000 (GMT)
Message-ID: <1805cb973c0e38e1ca8cbeb6dadc4f46f9475a0c.camel@linux.ibm.com>
Subject: Re: [RFC] IMA: periodic runtime re-measurement of process .text/GOT
From: Mimi Zohar <zohar@linux.ibm.com>
To: Nicolai Kuntze <nicolai.kuntze@hs-mainz.de>,
        linux-integrity@vger.kernel.org
Cc: James Bottomley <James.Bottomley@HansenPartnership.com>,
        Roberto Sassu	
 <roberto.sassu@huawei.com>,
        Dmitry Kasatkin <dmitry.kasatkin@gmail.com>,
        Eric Snowberg <eric.snowberg@oracle.com>,
        Paul Moore <paul@paul-moore.com>, James Morris <jmorris@namei.org>,
        "Serge E. Hallyn"	 <serge@hallyn.com>,
        linux-security-module@vger.kernel.org, linux-kernel@vger.kernel.org
In-Reply-To: <20260822193833.98211-1-nicolai.kuntze@hs-mainz.de>
References: <20260817102323.35950-1-nicolai.kuntze@hs-mainz.de>
	 <a5efe5059cd261c19496e602459fb37e3159817d.camel@linux.ibm.com>
	 <b13a1741eceeba4d4ec50e1c898e011ea81a178b.camel@HansenPartnership.com>
	 <20260822193833.98211-1-nicolai.kuntze@hs-mainz.de>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Date: Mon, 24 Aug 2026 09:17:25 -0400
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Evolution 3.58.3 (3.58.3-1.fc43) 
X-TM-AS-GCONF: 00
X-Proofpoint-Reinject: loops=2 maxloops=12
X-Proofpoint-ORIG-GUID: KYWRm-OPLmw7qgdUy4pURKq9icJnPh1J
X-Proofpoint-Spam-Info: AW1haW4tMjYwODI0MDEwOSBTYWx0ZWRfX65KvzzK1eg+1
 ALSnMqXyKG8PElgFdDN1OfmnpflZgeMIRjNtL/CtE0/oCaQzkjM9/aXDbVn3i1EBmvTyeFo+F+G
 WnGNdTCUJvZhNhxets2pJXwug6O/pjA=
X-Proofpoint-GUID: Vesi1w5MMZyfmRQO5WOstEt20bnYNIks
X-Authority-Analysis: v=2.4 cv=JZyMa0KV c=1 sm=1 tr=0 ts=6a8c4469 cx=c_pps
 a=GFwsV6G8L6GxiO2Y/PsHdQ==:117 a=GFwsV6G8L6GxiO2Y/PsHdQ==:17
 a=IkcTkHD0fZMA:10 a=Sv0fKeRqtYgA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=U7nrCbtTmkRpXpFmAIza:22 a=A5NGiW4cX679EOVUI_gA:9
 a=QEXdDO2ut3YA:10
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODI0MDEwOSBTYWx0ZWRfX00JHPGEX0yCG
 zcF8rLU9S1n914dB8ZGM7UInWmqhfuDWGZgtK4/uXOED18v6HGbvU5Ofvmi4w2BZ83dVVFoS/XF
 59xH+zwNmeJWpqyOz6JsGLkPhs/TgXXbc5wKn3Bw5TNvuljiBBj9HNjCBgTwBqLNICpdBU1z1Oy
 qVe6N/zGxe1fVUsLJz+OlwH8jSfnYBws7V43LLimqrlY0Y2g0NxkL86Zdgy29wOKwLRBxBnfqwB
 THS1KHiKxduioCuEjWl35wnURrjs1VCCH1HPSABK7Z3z+FPSoOz2cvzeV7LKEhsYrWn2cdRiPIX
 jrSU51mx/t9Mra741jaA1WuwZymPx48tV4hnUhsZcV49OAfsC7bV7yrgEewkxb7zj96tSYXNh2Q
 jkovxii4q1r5SVim3pqCVEcwRj2iy4UwMB5uVbG5WtBw/6hPCdpcFhsEcJ2it85K1Y9Rb91oyay
 Zv64NIqiibZPy6RJCCg==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-24_04,2026-08-24_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 clxscore=1015 adultscore=0 priorityscore=1501 impostorscore=0
 malwarescore=0 bulkscore=0 lowpriorityscore=0 suspectscore=0 phishscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2608240109

On Sat, 2026-08-22 at 21:38 +0200, Nicolai Kuntze wrote:
[...]

>=20
> > This feature is continuous/periodic ... a different execution
> > model, not an incremental addition to a hook-based architecture.
> > The reference implementation ... bypasses IMA's measurement list
> > and dedup entirely
>=20
> This was the strongest objection, and rather than argue it away I
> went back and changed the design -- v2 patches attached/linked below,
> not just a response in prose. You were right that a self-scheduling
> timer inside ima_main.c's dispatch is a materially different execution
> model, not an incremental addition to a hook-based one; the fix wasn't
> to defend the timer, it was to notice the actual requirement was never
> "recheck on a schedule," it was "answer a verifier's request," the
> same shape a TPM Quote already has. So v2 drops the timer and
> `interval=3D` entirely: RUNTIME_TEXT_CHECK/RUNTIME_GOT_CHECK/
> KERNEL_TEXT_CHECK are now dispatched from a one-shot trigger, a new
> write-only securityfs file (`/sys/kernel/security/ima/runtime_measure`,
> CAP_SYS_ADMIN-gated), the same event-triggered shape every other IMA
> hook already has -- the event is just "a verifier asked" instead of
> "a file was opened." Boot-tested under QEMU/KVM: a 5-second idle
> window with no write to `runtime_measure` produces zero measurement
> log lines; one write produces exactly one correctly-scoped batch;
> a further idle wait leaves the count unchanged, confirming it's
> genuinely one-shot and not a disguised timer restart.

Thank you.

>=20
> The measurement-list/dedup bypass you also flagged is a separate
> point from the execution-model one, and v2 does *not* change it: it's
> still deliberate, for the reason given in the original RFC -- an
> external verifier replaying the full PCR-extend chain needs every
> extend the TPM actually performed, including repeats of unchanged
> content, which is exactly what IMA's own digest-based dedup would
> throw away. v1's dedicated per-mapping dedup table (built to bound log
> growth from timer ticks nobody asked for) is dropped in v2 for the
> same reason it's no longer needed: growth is now bounded by how often
> a verifier actually requests a measurement, not by an on-device clock.

Extending the TPM is a performance concern =E2=80=94 that's why IMA caches =
the result.
CONFIG_IMA_DISABLE_HTABLE addresses the A-B-A case, where without it, a rep=
eat
of an earlier digest (A) gets skipped because it's already in the htable, m=
aking
the log misleadingly show only A-B. It doesn't change consecutive-repeat
behavior =E2=80=94 if the last hash was B and the new hash is still B, ther=
e's still no
need to add another B.

Why does this case need to be different? With extends now triggered per ver=
ifier
request rather than per tick, why does an unchanged digest still need a fre=
sh
extend on every request?


> It stays available, unchanged, for anyone who still wants periodic
> mode -- v1 is kept as sent-and-tested history, not deleted, just not
> the default.

Retaining v1 in your GitHub repo is up to you, but it wouldn't be upstreame=
d.

Mimi

> Does this address the concern, or is there a reason a request-driven
> hook still doesn't belong in ima_main.c's dispatch at all? Genuinely
> asking, not rhetorically -- if the list still prefers the
> separate-mechanism route (kthread/LSM-adjacent/eBPF, reusing IMA's
> measurement list and PCR extend chain as a pure data sink without
> adopting its hook model), I'd rather hear that now than after more
> patches build on the current shape.
