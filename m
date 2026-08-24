Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BC1E719E97B;
	Mon, 24 Aug 2026 14:23:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787581398; cv=none; b=J2Fll3l2AGl/uOWUjjqv5xi5AAwWRXL2JDkiEZRbiCDgyPwiCJGzPMmBDnKE+cvs9S9XPHfs6DXmRUK7qeQT/0ckjjs2+f4SS7o1e6xULUV4lP1Spcfw6ainfxFRTAFP9nXGWOlm5r69xRI6A2d2SlOmEBWFG7sJOipcWYIYpIs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787581398; c=relaxed/simple;
	bh=5jZ5GsURY/r/xgFUCiDk967qKNFlaZ3K1FaH8xTjeW0=;
	h=Message-ID:Subject:From:To:Cc:In-Reply-To:References:Content-Type:
	 Date:MIME-Version; b=jZMEISUzQcTpFOUbkmssuPfg2ShfboaPSKOIi1W5sxGx7tgGMzBvglsnEAp/JnglabxixvlL3pMOT7WClHiQFtM1Dx+vRAyTyNfRZ8pN2jmrq6t/m73K6uoiILB3Y4oXy0yJ55gRI0gyNwXXgMW6l2LLnMNHk/uoUVIW8l31otg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=LqJ0uHUV; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="LqJ0uHUV"
Received: from pps.filterd (m0356516.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 67OD1qu91846125;
	Mon, 24 Aug 2026 14:22:56 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=Jf92XV
	BJaBqmY0ZhM4WIGyFFmjfb58X8QC6VCChI+0U=; b=LqJ0uHUVNGsBkuQbltSHuD
	8+eOd4EN8APanOOTDelASnqgSx3mnjwJUMaAVr+FErgiVeMrrFqc6V1uY8D7/5Ns
	KykGy4hB8pIUsTs4WI70FEeKVXcZ69Iyvb7XJ5n2mZW8P/X0RH88Nwkh9ujfIkyY
	wBB/L0VZ9zOGxVM1o3cA4zWEeFXRAaHLZRrsDJ5sGw6X0iooUhIx+uA72IT+BOVK
	GKUp2ibCrfYUJPojgUeiP/vXd+tXFeFpH7DYyPFHkO31VDoSPih19K85YOwfuYKh
	H5g/zXpdI1QU9FMVxl+A3zRj8vRlPB29Wtzcq1pu77ojjmKvP73ZqdrkTN47pyrQ
	==
Received: from ppma21.wdc07v.mail.ibm.com (5b.69.3da9.ip4.static.sl-reverse.com [169.61.105.91])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4g716hj477-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 24 Aug 2026 14:22:55 +0000 (GMT)
Received: from pps.filterd (ppma21.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma21.wdc07v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 67OEBGEk007852;
	Mon, 24 Aug 2026 14:22:55 GMT
Received: from smtprelay02.wdc07v.mail.ibm.com ([172.16.1.69])
	by ppma21.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4g7q3jpf6j-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 24 Aug 2026 14:22:55 +0000 (GMT)
Received: from smtpav01.wdc07v.mail.ibm.com (smtpav01.wdc07v.mail.ibm.com [10.39.53.228])
	by smtprelay02.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 67OEMsNJ18154056
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 24 Aug 2026 14:22:54 GMT
Received: from smtpav01.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 97B1458059;
	Mon, 24 Aug 2026 14:22:54 +0000 (GMT)
Received: from smtpav01.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 81B8D5804B;
	Mon, 24 Aug 2026 14:22:53 +0000 (GMT)
Received: from li-43857255-d5e6-4659-90f1-fc5cee4750ad.ibm.com (unknown [9.61.146.167])
	by smtpav01.wdc07v.mail.ibm.com (Postfix) with ESMTP;
	Mon, 24 Aug 2026 14:22:53 +0000 (GMT)
Message-ID: <cf79fc0314c1984e68f683d26cbee3ac0859b5d6.camel@linux.ibm.com>
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
In-Reply-To: <1805cb973c0e38e1ca8cbeb6dadc4f46f9475a0c.camel@linux.ibm.com>
References: <20260817102323.35950-1-nicolai.kuntze@hs-mainz.de>
		 <a5efe5059cd261c19496e602459fb37e3159817d.camel@linux.ibm.com>
		 <b13a1741eceeba4d4ec50e1c898e011ea81a178b.camel@HansenPartnership.com>
		 <20260822193833.98211-1-nicolai.kuntze@hs-mainz.de>
	 <1805cb973c0e38e1ca8cbeb6dadc4f46f9475a0c.camel@linux.ibm.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Date: Mon, 24 Aug 2026 10:22:52 -0400
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Evolution 3.58.3 (3.58.3-1.fc43) 
X-TM-AS-GCONF: 00
X-Proofpoint-Reinject: loops=2 maxloops=12
X-Proofpoint-Spam-Info: AW1haW4tMjYwODI0MDExOCBTYWx0ZWRfX8IdE7Y/VJA/q
 zCs7jYOsNkqkP/2qL+EcTrxhrjtyUZUQ78EaeSmYPvchFCHv0sv285+eRTiIahyIGVlt3DSPa9f
 5NMpJY4J9uP/sFSdcC9G+ICJPz3Yp9k=
X-Proofpoint-GUID: r1vicECL8DgmkOh05BSWfCzeNgK8KyeM
X-Proofpoint-ORIG-GUID: D2lHRxdHK7_d1n3as0Vx0qx1r7Z5aOOb
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODI0MDExOCBTYWx0ZWRfX8YSx1rgGQHQ8
 AlzSIS7+YVffFoi2MEy2okHDbjlibUeeeTqyiZPgc8kWIn726LAliZ5Eq//qmW18DkBTen5KWFy
 JuPW/JmpfoZCXcH83vQd7a6UMJFX5r3NpqfZ7z4jYZ8Sx6K668oG0VieJV6m5i4Z8PYt6EW5ZqW
 JTmkBVKeACPeLyp2WxrMK+HtHKsWXRwGlKf5AmiO31mFfbS/dO8PuisFM7u6tKqd3ECUyPX55cq
 SIVNiyNfp7bsGzivQ8+jsJIaKZdotR7wARDjri9YijLKxKNyOxQ6eaYyMND7/dQ48c04aEB6eYz
 SGnX5whiJeJVRsuP3j+qEo6rdWgC2TMufZF+OXX2xqWoKvpyGtnQNW4fMQaylC/u1kINHgOt+oQ
 9JE1seFbWuNFCGeHTG02fQvCipSO8GOzHNyIoFgKKba9+SA1B24BaJQQ5zdwiajVlMEQZud4CAJ
 VcLoCiYFeJms0EUBN7Q==
X-Authority-Analysis: v=2.4 cv=H7brBeYi c=1 sm=1 tr=0 ts=6a8c53c0 cx=c_pps
 a=GFwsV6G8L6GxiO2Y/PsHdQ==:117 a=GFwsV6G8L6GxiO2Y/PsHdQ==:17
 a=IkcTkHD0fZMA:10 a=Sv0fKeRqtYgA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=Y2IxJ9c9Rs8Kov3niI8_:22 a=mirx2vBVZkB8IbZm90QA:9
 a=QEXdDO2ut3YA:10
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-24_04,2026-08-24_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 malwarescore=0 lowpriorityscore=0 impostorscore=0 spamscore=0
 bulkscore=0 adultscore=0 priorityscore=1501 clxscore=1015 phishscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2608240118

On Mon, 2026-08-24 at 09:17 -0400, Mimi Zohar wrote:
> On Sat, 2026-08-22 at 21:38 +0200, Nicolai Kuntze wrote:
> [...]
>=20
> >=20
> > > This feature is continuous/periodic ... a different execution
> > > model, not an incremental addition to a hook-based architecture.
> > > The reference implementation ... bypasses IMA's measurement list
> > > and dedup entirely
> >=20
> > This was the strongest objection, and rather than argue it away I
> > went back and changed the design -- v2 patches attached/linked below,
> > not just a response in prose. You were right that a self-scheduling
> > timer inside ima_main.c's dispatch is a materially different execution
> > model, not an incremental addition to a hook-based one; the fix wasn't
> > to defend the timer, it was to notice the actual requirement was never
> > "recheck on a schedule," it was "answer a verifier's request," the
> > same shape a TPM Quote already has. So v2 drops the timer and
> > `interval=3D` entirely: RUNTIME_TEXT_CHECK/RUNTIME_GOT_CHECK/
> > KERNEL_TEXT_CHECK are now dispatched from a one-shot trigger, a new
> > write-only securityfs file (`/sys/kernel/security/ima/runtime_measure`,
> > CAP_SYS_ADMIN-gated), the same event-triggered shape every other IMA
> > hook already has -- the event is just "a verifier asked" instead of
> > "a file was opened." Boot-tested under QEMU/KVM: a 5-second idle
> > window with no write to `runtime_measure` produces zero measurement
> > log lines; one write produces exactly one correctly-scoped batch;
> > a further idle wait leaves the count unchanged, confirming it's
> > genuinely one-shot and not a disguised timer restart.
>=20
> Thank you.

Have you considered defining this as an IMA critical-data measurement, trig=
gered
by the securityfs write?  That way the verifier wouldn't need any informati=
on
beyond what's already in the IMA measurement list.

Mimi

>=20
> >=20
> > The measurement-list/dedup bypass you also flagged is a separate
> > point from the execution-model one, and v2 does *not* change it: it's
> > still deliberate, for the reason given in the original RFC -- an
> > external verifier replaying the full PCR-extend chain needs every
> > extend the TPM actually performed, including repeats of unchanged
> > content, which is exactly what IMA's own digest-based dedup would
> > throw away. v1's dedicated per-mapping dedup table (built to bound log
> > growth from timer ticks nobody asked for) is dropped in v2 for the
> > same reason it's no longer needed: growth is now bounded by how often
> > a verifier actually requests a measurement, not by an on-device clock.
>=20
> Extending the TPM is a performance concern =E2=80=94 that's why IMA cache=
s the result.
> CONFIG_IMA_DISABLE_HTABLE addresses the A-B-A case, where without it, a r=
epeat
> of an earlier digest (A) gets skipped because it's already in the htable,=
 making
> the log misleadingly show only A-B. It doesn't change consecutive-repeat
> behavior =E2=80=94 if the last hash was B and the new hash is still B, th=
ere's still no
> need to add another B.
>=20
> Why does this case need to be different? With extends now triggered per v=
erifier
> request rather than per tick, why does an unchanged digest still need a f=
resh
> extend on every request?
>=20
>=20
> > It stays available, unchanged, for anyone who still wants periodic
> > mode -- v1 is kept as sent-and-tested history, not deleted, just not
> > the default.
>=20
> Retaining v1 in your GitHub repo is up to you, but it wouldn't be upstrea=
med.
>=20
> Mimi
>=20
> > Does this address the concern, or is there a reason a request-driven
> > hook still doesn't belong in ima_main.c's dispatch at all? Genuinely
> > asking, not rhetorically -- if the list still prefers the
> > separate-mechanism route (kthread/LSM-adjacent/eBPF, reusing IMA's
> > measurement list and PCR extend chain as a pure data sink without
> > adopting its hook model), I'd rather hear that now than after more
> > patches build on the current shape.
