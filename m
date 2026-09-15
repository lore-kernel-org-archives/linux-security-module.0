Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 66F2743B3E6;
	Tue, 15 Sep 2026 21:32:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789507960; cv=none; b=lcD6V/ND3La6dZ+cxbtY4d30mp5R59/OXx7hCzu43ivTQcmbpJ40MRWIwhAN9lwE01FToDGxFNn67walgkg7fBC4UH2Eq7irwLWjEXH0x+pHYEvzuPEfhyDBRe3Mw6xU0k0VYeDygOp+cBF/7EaTclxNuqICeeX751C5jlk/LbE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789507960; c=relaxed/simple;
	bh=iJIwyB765EM3XFe3QC8bvt6dtm5ovpJNPJeUGu2SYtw=;
	h=Message-ID:Subject:From:To:Cc:In-Reply-To:References:Content-Type:
	 Date:MIME-Version; b=kH2RZpjhCZ8wpcjTsGZRW0UPoA6C0DdYdXUCPWFJslU6gSxFje6xJCPn8kEv1Oszrr8KawgaRps/6dSuOUNrpa4ZgMhe9e1e/tLiMv9CgfQsdKV5IsJCtylHpUnCXtvuoP1/EYq3v5zw0J4QAQnuGJIXYVWahdyzWGfxn2fJh14=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=BjIKOW90; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="BjIKOW90"
Received: from pps.filterd (m0360072.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 68FLW6NR1990570;
	Tue, 15 Sep 2026 21:32:15 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=jwirPE
	P/2vdYiKFo3DHec1VsjsWrlvu2hreVrMZUWak=; b=BjIKOW90ImsxxN05wQCxIp
	lzJV/bURTY/H45pFk07YsHxjZncNhNLsAcOwgmzGjeFA2cKNFn3GvZ7hS/6xEcGE
	Jp6WLq9bl3esb0sty5IxlPcPeTAlagHfVvTP2+D6uzwkwtJw9YLh0pjutTggFVPu
	/UWFkBBgvCNTniJtjhecsyDpF79RpIMPHZVLszOzxwz8dsSuO9XMUI772HJIQUSD
	aFFuednJ+Lqu5p8t1hb6hVmXJGKylSqdr39CtF94bGnHU9URZhPWi9nfU/rlOf7w
	6/oy5ldlBoBDC1KICnVI4njK1PFsG+YaXqFZrZ0VGTtpj6tiXThm7BqtVGooPWEw
	==
Received: from ppma23.wdc07v.mail.ibm.com (5d.69.3da9.ip4.static.sl-reverse.com [169.61.105.93])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4gmxcv16ng-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Tue, 15 Sep 2026 21:32:15 +0000 (GMT)
Received: from pps.filterd (ppma23.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma23.wdc07v.mail.ibm.com (8.18.1.11/8.18.1.11) with ESMTP id 68FJ57Lw245680;
	Tue, 15 Sep 2026 21:32:14 GMT
Received: from smtprelay06.dal12v.mail.ibm.com ([172.16.1.8])
	by ppma23.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4gq089kdwg-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 15 Sep 2026 21:32:14 +0000 (GMT)
Received: from smtpav02.dal12v.mail.ibm.com (smtpav02.dal12v.mail.ibm.com [10.241.53.101])
	by smtprelay06.dal12v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 68FLWD408061602
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 15 Sep 2026 21:32:14 GMT
Received: from smtpav02.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id D82DE5805A;
	Tue, 15 Sep 2026 21:32:13 +0000 (GMT)
Received: from smtpav02.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 32AAA5805C;
	Tue, 15 Sep 2026 21:32:13 +0000 (GMT)
Received: from li-43857255-d5e6-4659-90f1-fc5cee4750ad.ibm.com (unknown [9.31.104.242])
	by smtpav02.dal12v.mail.ibm.com (Postfix) with ESMTP;
	Tue, 15 Sep 2026 21:32:13 +0000 (GMT)
Message-ID: <c2a8a6b2e55bc0cf062bbfea045eb1f593149e5f.camel@linux.ibm.com>
Subject: Re: [PATCH v2 1/3] integrity: Replace all uses of
 integrity_audit_msg() with integrity_audit_message()
From: Mimi Zohar <zohar@linux.ibm.com>
To: Frederick Lawler <fred@cloudflare.com>
Cc: Roberto Sassu <roberto.sassu@huawei.com>,
        Dmitry Kasatkin	
 <dmitry.kasatkin@gmail.com>,
        Eric Snowberg <eric.snowberg@oracle.com>,
        Paul
 Moore <paul@paul-moore.com>, James Morris <jmorris@namei.org>,
        "Serge E.
 Hallyn"	 <serge@hallyn.com>,
        linux-integrity@vger.kernel.org, linux-security-module@vger.kernel.org,
        linux-kernel@vger.kernel.org, kernel-team@cloudflare.com
In-Reply-To: <ykq6awewbz2f4ckgwrwnubcprlta2trm24by6bw3z2q6u6mr43@gn6ajl46tc6r>
References: <20260727-report-hash-error-v2-0-30e394f524fc@cloudflare.com>
	 <20260727-report-hash-error-v2-1-30e394f524fc@cloudflare.com>
	 <1214eed319ccb441ba0cd26ce168a0383a3e41c6.camel@linux.ibm.com>
	 <ykq6awewbz2f4ckgwrwnubcprlta2trm24by6bw3z2q6u6mr43@gn6ajl46tc6r>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Date: Tue, 15 Sep 2026 17:32:12 -0400
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Evolution 3.58.3 (3.58.3-1.fc43) 
X-TM-AS-GCONF: 00
X-Proofpoint-Reinject: loops=2 maxloops=12
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTE1MDMxNCBTYWx0ZWRfX2QuAyhP+05mQ
 iCWuwC50DoA9h2paXnAA5rqgwt4HtvUntLBl8cEJWiVF4JCbBUdaCgyXzrwJBISXi6pRNF73IX7
 semZBxWHTwDOnbeFyX0O1VVGjCIVvf8=
X-Proofpoint-ORIG-GUID: WJh87iaX5-NKarW41dNN5locBf8UfVjh
X-Proofpoint-GUID: 4v_ah-CXMPydT4HRKR6XRcVmIFktwjac
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTE1MDMxNCBTYWx0ZWRfXzJ2cUhuLiPzn
 J0pzshTwQHQCX4gQftUnz1cCtSs1wYZoovC0lDUYikjuQ1dUDC/o4x8uT1JTiC042Jdg1hD1guJ
 aAy5HIabp8ae39429LQtd8tJ/Q285250CayDfPl1G4KE+4nvmHxC7yVvzmTBI0tNagRHi0kKw21
 2GDfXu7PZ8FjgNz+7rCgcNjEWy6mPRgqhN8iczspELO9ianxMx3pVDAtrz26aiVH5SuL0Nty5vp
 Jb1EjZFC8UQarNAeqXtqQVFzDu2de0wLvywZXB7ljovd+4XKAHHlsL/1E090xPc8hg+hH9/wUgp
 sh8DcU81Y2oVLhZzX3PMmzose59OrTH7cosHD+JEZqDRZ63PzMqgzNX6ugUL2LuEKIU33EnT17o
 uJ6VgTmxlVJcih/hRNkgOBLv4UFMW26pN8jXbcOZY3/xDjoYxpsbrOa4gr5F8l/k+YJItyu18GY
 1aKBhBlToJE0Jo2sEJA==
X-Authority-Analysis: v=2.4 cv=F+7C5ahN c=1 sm=1 tr=0 ts=6aa9b95f cx=c_pps
 a=3Bg1Hr4SwmMryq2xdFQyZA==:117 a=3Bg1Hr4SwmMryq2xdFQyZA==:17
 a=IkcTkHD0fZMA:10 a=VdqzKS8jKosA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=RzCfie-kr_QcCd8fBx8p:22 a=EG7W4yiQAAAA:8
 a=KaHl30EOXU6AYE5tbzAA:9 a=QEXdDO2ut3YA:10
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-15_05,2026-09-15_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 suspectscore=0 phishscore=0 clxscore=1015 malwarescore=0
 lowpriorityscore=0 bulkscore=0 spamscore=0 impostorscore=0 adultscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2609040000 definitions=main-2609150314

On Tue, 2026-09-15 at 16:08 -0500, Frederick Lawler wrote:
> Hi Mimi,
>=20
> On Tue, Sep 15, 2026 at 04:00:34PM -0400, Mimi Zohar wrote:
> > On Mon, 2026-07-27 at 17:21 -0500, Frederick Lawler wrote:
> > > integrity_audit_msg() wraps integrity_audit_message() such that
> > > error codes are hidden by passing an additional parameter to
> > > integrity_audit_message(). Since this is a wrapper, we can replace
> > > this function with integrity_audit_message() introduced in commit
> > > 2f845882ecd2 ("integrity: Add errno field in audit message")
> > >=20
> > > No functional change intended.
> >=20
> > There's an unintentional change in ima_write_policy(), which replaces t=
he
> > existing '1' with result.
>=20
> Oof. Good catch. That was intended for the later patch.
>=20
> >=20
> > >=20
> > > Signed-off-by: Frederick Lawler <fred@cloudflare.com>
> >=20
> > Is renaming integrity_audit_msg() to integrity_audit_message() actually=
 the
> > right approach here?  integrity_audit_message() currently has only 2 ca=
llers vs.
> > ~20+ for integrity_audit_msg(), and the rename forces re-wrapping of ev=
ery
> > multi-line call site since integrity_audit_message is 4 chars longer, b=
loating
> > the first patch.
> >=20
> > Why not simply add errno to the integrity_audit_msg() definition and ca=
llers. =20
> >=20
>=20
> I can switch that around. I assumed we'd want to keep _message() since
> that was wrapped by _msg(). And not dealing with the line-wrapping is
> better.

No, making integrity_audit_msg() a wrapper for integrity_audit_message was =
done
for expediency, instead of changing ALL the integrity_audit_msg() call site=
s.

Thank you for taking the time to review all the integrity_audit_msg() call =
sites
and adding errno..

Mimi







