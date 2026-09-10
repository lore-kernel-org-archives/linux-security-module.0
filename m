Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3C66F196C7C;
	Thu, 10 Sep 2026 01:23:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789003412; cv=none; b=R9S8lfZXEJ3h1b3I71GUCq2sPfuPHtBUQDDvnS+g1Eu/+i2YUfv0mfiJYMGbpexLAhKANIR5ljH6ygsZrZBg5zjAd2Mb8FwVYVmKMZjUGHi7qhev/2fyNBwzMKBkq81oPZYcCkNBtgINOMUJJp7InUEWk9ipH7nQfSw7zv2Jrro=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789003412; c=relaxed/simple;
	bh=cd4/itkR2z/uYptRKT8sgjBiPd3C482KD0TEqaf3ySg=;
	h=Message-ID:Subject:From:To:Cc:In-Reply-To:References:Content-Type:
	 Date:MIME-Version; b=Eh2FKL5uL0mNtXZOsncQC3ZIKVdmiRu6hDVH9E7Io/pzUSVYWCIFj+yABuk1LTp4vuroVFMSmgBNs5zHXZXUQijxxA1w3V4kKtUYWblDRLEh4t/c/L1beTWqFaKl5y30mLeuR5BiBjsg+h7eYP8EqJWX9nI/Ff9NtOvHirKCSXU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=aIt1Cf8h; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="aIt1Cf8h"
Received: from pps.filterd (m0356517.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 689MVmbb1075777;
	Thu, 10 Sep 2026 01:23:09 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=bSdP0m
	KK6GEv6pHkHPvouHqxEGB7Xe7KCWL0InguvIQ=; b=aIt1Cf8hyN+tC5MshNUn7O
	5Cip4979ZDtWloMY5S16HL4lvu4r0EVfbEfegH6ZEw8mJSAWBoIVEz+vcfGbyai1
	c5do8TfgzbRcv1rJpoDSXTs+97SozYkSyYsNZuasvCeLkSvWJWETxF2fG6RA6hRm
	EwuyTYk6T2ucLMg6mJEuFKs1fnMuZrpLME5IZwazXsB3qbAk0x3Ydx6F3u8qo0k9
	iswElTWzn50ixBLA0rscFB9cEp5alcg1GjLHdSy8lAKUeUdH24i0bps8CNdI4Dkv
	Nj8KrRE6SU4MW9wMyg6oJtw3v16FtwS7yJXLEkBE+LRq5Fhcgm6l78V//8KeA4CA
	==
Received: from ppma11.dal12v.mail.ibm.com (db.9e.1632.ip4.static.sl-reverse.com [50.22.158.219])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4gkd8phkfr-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 10 Sep 2026 01:23:09 +0000 (GMT)
Received: from pps.filterd (ppma11.dal12v.mail.ibm.com [127.0.0.1])
	by ppma11.dal12v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 68A1BCiF010380;
	Thu, 10 Sep 2026 01:23:08 GMT
Received: from smtprelay04.dal12v.mail.ibm.com ([172.16.1.6])
	by ppma11.dal12v.mail.ibm.com (PPS) with ESMTPS id 4gkcr31qgx-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 10 Sep 2026 01:23:08 +0000 (GMT)
Received: from smtpav02.wdc07v.mail.ibm.com (smtpav02.wdc07v.mail.ibm.com [10.39.53.229])
	by smtprelay04.dal12v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 68A1N7Z818023110
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 10 Sep 2026 01:23:07 GMT
Received: from smtpav02.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 70ED95805B;
	Thu, 10 Sep 2026 01:23:07 +0000 (GMT)
Received: from smtpav02.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 0A30D58059;
	Thu, 10 Sep 2026 01:23:06 +0000 (GMT)
Received: from li-43857255-d5e6-4659-90f1-fc5cee4750ad.ibm.com (unknown [9.61.156.196])
	by smtpav02.wdc07v.mail.ibm.com (Postfix) with ESMTP;
	Thu, 10 Sep 2026 01:23:05 +0000 (GMT)
Message-ID: <64cd28d394d692c9a452d7262190fff6f4b6c328.camel@linux.ibm.com>
Subject: Re: [PATCH v2 0/3] integrity: Return error codes in audit messages
From: Mimi Zohar <zohar@linux.ibm.com>
To: Frederick Lawler <fred@cloudflare.com>,
        Roberto Sassu	
 <roberto.sassu@huawei.com>,
        Dmitry Kasatkin <dmitry.kasatkin@gmail.com>,
        Eric Snowberg <eric.snowberg@oracle.com>,
        Paul Moore <paul@paul-moore.com>, James Morris <jmorris@namei.org>,
        "Serge E. Hallyn"	 <serge@hallyn.com>
Cc: linux-integrity@vger.kernel.org, linux-security-module@vger.kernel.org,
        linux-kernel@vger.kernel.org, kernel-team@cloudflare.com
In-Reply-To: <weadqcqqw3e4snwysfnx2fszrxctppkqqgdjrkfyn7uh5poczp@dpnp6tl3mk6u>
References: <20260727-report-hash-error-v2-0-30e394f524fc@cloudflare.com>
	 <weadqcqqw3e4snwysfnx2fszrxctppkqqgdjrkfyn7uh5poczp@dpnp6tl3mk6u>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Date: Wed, 09 Sep 2026 21:23:04 -0400
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Evolution 3.58.3 (3.58.3-1.fc43) 
X-TM-AS-GCONF: 00
X-Proofpoint-Reinject: loops=2 maxloops=12
X-Authority-Analysis: v=2.4 cv=eM2GH3p1 c=1 sm=1 tr=0 ts=6aa2067d cx=c_pps
 a=aDMHemPKRhS1OARIsFnwRA==:117 a=aDMHemPKRhS1OARIsFnwRA==:17
 a=IkcTkHD0fZMA:10 a=VdqzKS8jKosA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=U7nrCbtTmkRpXpFmAIza:22 a=VwQbUJbxAAAA:8
 a=EG7W4yiQAAAA:8 a=URXeEHRefUtLXCjPl0oA:9 a=QEXdDO2ut3YA:10
X-Proofpoint-ORIG-GUID: U8LCBmuhUfoPQgk4O1q5qjsSWqHL8TfO
X-Proofpoint-GUID: Sa64SLqVefjn_jmohwpB-G4y8RvPQ0Kx
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTEwMDAwOSBTYWx0ZWRfX9rmQIkhA3bbB
 VRQ+ImBp96mUPxlJSZv4lMfJaPS46rjt+h4yRYL8VUx47hzb2bKTEDysHgbxxwJJMnba6AUxIYW
 /EjfCB1XbIQo7088JRIQ19Xm4VdazIY=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTEwMDAwOSBTYWx0ZWRfX/j5s6e4zoxLk
 x+0YDzEINdLX91gL1064SPWl2rFhQ5UR2+S3O0ZMrbXoR5T5DdhPIYskI0YAy+sCYLLamOxpMJD
 ECPIduGkoJnpT0Sxbmfg+88/9YTzC1DeBMif5PY0+Te0PuIreaiKEiK2H5uEMvitbG+NZXHXHf9
 Fdis3b+VY4712RhUpLhrkOJoPbsWiD+o11NYOyKi7aFDTFJmSGC9h/F/2qh1o2d8tKFoNnuo2jt
 ytA1BPXYkft1JqNjVwuZD1iwlv2hllsS9y1baKMj919Q5AJKgwXqKmUE/kZwTS63PMaH6OJqNcV
 TyRBPy6LpI4lCzrpADvT8JrFKfiHHJRmazm/nDeWBoUsXk0MYcN9CUQ16TAAurR6zzgHb3Ui1IP
 OYU5CC17+YYJ/VpPEKD/47tl6AMW5dssIti7a+BwaTWb9b1i9qQb/14sf9ChEgsOomQ8a4/cfiU
 FKuLsEeJuGoN6w3Xsaw==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-09_02,2026-09-09_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 impostorscore=0 malwarescore=0 adultscore=0 phishscore=0
 lowpriorityscore=0 suspectscore=0 spamscore=0 priorityscore=1501 bulkscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2609040000 definitions=main-2609100009

On Wed, 2026-09-09 at 12:53 -0500, Frederick Lawler wrote:
> Hi Mimi and Roberto,
>=20
> On Mon, Jul 27, 2026 at 05:21:46PM -0500, Frederick Lawler wrote:
> > Commit 2f845882ecd2 ("integrity: Add errno field in audit message")
> > introduced an audit log function that can take an error code. It is
> > wrapped by integrity_audit_msg() that implicitly sets the error code
> > argument to zero. The problem is that there are uses of integrity_audit=
_msg()
> > such as ima_collect_measurement() that hide the failure cause for
> > the message.
> >=20
> > This series aims to convert integrity_audit_msg() call sites to
> > integrity_audit_message(), and then expose error codes based on the
> > following criteria:
> >=20
> >     1. The log depends on a result from earlier callee, and/or
> >     2. The caller function itself returns with that result
> >=20
> > ima_release_policy() is the only caller I thought made sense to keep as
> > is. The message doesn't correlate with a return code, nor does it
> > depend on a result from an earlier callee in the function.
> >=20
> > Signed-off-by: Frederick Lawler <fred@cloudflare.com>
> > ---
> > This is probably a bit more than what was asked from v1, but as I was
> > making changes and looking at other call sites, I didn't think it made
> > sense to keep integrity_audit_msg() around anymore.
> >=20
> > Changes in v2:
> > - Changes from v1 are now reflected in patch 3.
> > - Replace all instances of integrity_audit_msg().
> > - Convert to patch series.
> > - Link to v1: https://lore.kernel.org/r/20260716-report-hash-error-v1-1=
-ac19281112e4@cloudflare.com
> >=20
>=20
> I think this series may have fallen through the cracks between the merge
> windows. Shall I respin + rebase?

Thanks for the reminder.  Let me take a look at it again, before you post
another version.  It might take a few days until I get to it.

Thanks,

Mimi
