Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B8D4839021A;
	Tue, 15 Sep 2026 20:00:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789502458; cv=none; b=KgJO/owHMtMrFwZakRpR+w3KziegfAUI7se0Mpnzl2q/9J7HLhQ1v+C8EcTkFM3CIML7Nfc1PVQk473s40wZINQyQR/AT9oErTiu59L5F9Jp4AONhKZLDDf4PhNZwllVMsIhHTRXIeS4Z2mXsr7EDLLT49gLxOl5QttRSY1kF2E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789502458; c=relaxed/simple;
	bh=CBFhwNPSpRf+qcat7jprHG0IL9YA86IPQndhHX3D9m0=;
	h=Message-ID:Subject:From:To:Cc:In-Reply-To:References:Content-Type:
	 Date:MIME-Version; b=aU64xSQrBY84MgNqavlsCf5eEtuqYxKHfVo8aUSW9Vt8rt+iM7oEKUa/r2ZNEGjQK/0rlnCv6FhaUm3nVWkI2S8vJ/iXPeyWoMOvJBvnYvWj0Y3VTUIhcWidQkMSzmc7XjVxAd5I/38uCWTVUiaGfm528Mp3HN8fg8H19Cwy3DM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=Zrcv5+64; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="Zrcv5+64"
Received: from pps.filterd (m0353729.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 68FJ1SHY3959740;
	Tue, 15 Sep 2026 20:00:38 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=O2tXJ6
	oO/ItHf3IBZtqDlhyITKFIyuuNpiQx9tZXvxE=; b=Zrcv5+64ms4O+rbWV702Md
	LHzA9juUOTyDZafA8QqlmAUtvTApeynhXgAizydfz0cSJUZ66i8mzJKT3xRpE0o0
	IXsAU+2G+yV4cadekAb3EX0OpvQ+qkqnNEXxDrExaNOJgeoOgkNQCGycjthoTNCz
	MMjTC20+vyu1J10L+KlcURfYzVDPJIgE7KIGiaXDLQYorOTLFFZ9wIgtF/HqEog3
	Y72dIhJSBGMkj3H1xUWuh3a8a9ZJCTBd6Wb8Gu6aWezz9OLpe0cBVe0WTDtME2GW
	hgjOADnif2xwL+blzvjniG+oXFc7jZdF+u0uTXAOEa7fvHjqGwH/ogQQAXcJodYw
	==
Received: from ppma13.dal12v.mail.ibm.com (dd.9e.1632.ip4.static.sl-reverse.com [50.22.158.221])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4gmxdq959q-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Tue, 15 Sep 2026 20:00:37 +0000 (GMT)
Received: from pps.filterd (ppma13.dal12v.mail.ibm.com [127.0.0.1])
	by ppma13.dal12v.mail.ibm.com (8.18.1.11/8.18.1.11) with ESMTP id 68FJ54TP296490;
	Tue, 15 Sep 2026 20:00:36 GMT
Received: from smtprelay01.wdc07v.mail.ibm.com ([172.16.1.68])
	by ppma13.dal12v.mail.ibm.com (PPS) with ESMTPS id 4gpyweu5uv-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 15 Sep 2026 20:00:36 +0000 (GMT)
Received: from smtpav02.wdc07v.mail.ibm.com (smtpav02.wdc07v.mail.ibm.com [10.39.53.229])
	by smtprelay01.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 68FK0a7c918408
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 15 Sep 2026 20:00:36 GMT
Received: from smtpav02.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 18C5C5805B;
	Tue, 15 Sep 2026 20:00:36 +0000 (GMT)
Received: from smtpav02.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 2B60D5805C;
	Tue, 15 Sep 2026 20:00:35 +0000 (GMT)
Received: from li-43857255-d5e6-4659-90f1-fc5cee4750ad.ibm.com (unknown [9.31.104.242])
	by smtpav02.wdc07v.mail.ibm.com (Postfix) with ESMTP;
	Tue, 15 Sep 2026 20:00:35 +0000 (GMT)
Message-ID: <1214eed319ccb441ba0cd26ce168a0383a3e41c6.camel@linux.ibm.com>
Subject: Re: [PATCH v2 1/3] integrity: Replace all uses of
 integrity_audit_msg() with integrity_audit_message()
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
In-Reply-To: <20260727-report-hash-error-v2-1-30e394f524fc@cloudflare.com>
References: <20260727-report-hash-error-v2-0-30e394f524fc@cloudflare.com>
	 <20260727-report-hash-error-v2-1-30e394f524fc@cloudflare.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Date: Tue, 15 Sep 2026 16:00:34 -0400
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Evolution 3.58.3 (3.58.3-1.fc43) 
X-TM-AS-GCONF: 00
X-Proofpoint-Reinject: loops=2 maxloops=12
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTE1MDI4NSBTYWx0ZWRfX4alFxgDsxSDC
 E/2jPynO4YialOgLQYGZ9qWMvQs4X7tKsskV0kBaWIw798kHq2qJFxDl5rK9VqpGM7iaxajgyeC
 2JAubEMzG60VXKbDwG4cIiCsVhDj7SkEp57JNIBs2zru3NeXPxFRLt3m/y6oiYIx313QXULamMX
 Tc4g07WGz8SSfWgq8J93ieqDW/yWP5Hf0Y5siog+1X3eyWrM4sNWg0vRM2NY19VPSC9k3SAMUUX
 4+sKfhmdYix4PNvSAY6P1KLlnHH5FCuP8aMPEtNwje3QTKKX046in0wp+3C25rifah+GwHgtupY
 AA5CKJTws9Yv0PWlDjeRXWDtLd7yW20sEXVCHgwNqhJT3onmK1rHLXDJcBfbCrlRyOXCZbBGw1Q
 K6/mTVq1jPgVP4D2LOWuXmhJ/jBYPu7ckZcpJEC+OqBJbr51f0v7v1fYe3cDVgyPadTNCGlAAnj
 9k53/cQiJBQ4LJzqGPQ==
X-Proofpoint-GUID: RM_DM6FOZ-obX25xALZGZADgLQpZGd93
X-Authority-Analysis: v=2.4 cv=DobDa2/+ c=1 sm=1 tr=0 ts=6aa9a3e6 cx=c_pps
 a=AfN7/Ok6k8XGzOShvHwTGQ==:117 a=AfN7/Ok6k8XGzOShvHwTGQ==:17
 a=IkcTkHD0fZMA:10 a=VdqzKS8jKosA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=uAbxVGIbfxUO_5tXvNgY:22 a=EG7W4yiQAAAA:8
 a=JMpQnried2O94CoTtOIA:9 a=QEXdDO2ut3YA:10
X-Proofpoint-ORIG-GUID: WT5iFc5wGFolQimlXxvyPlPUqGIIvL3x
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTE1MDI4NSBTYWx0ZWRfXwb3gYfKt7o95
 R6sleM8Y+OeAyhSWQsndhG8v8VhBiGSWspQWHzPiUPNc+mkrt0S0OPIJn/NEhMjL1GkKzHfsX9G
 20LUzYtCG+sTXyyFqYgmYPR25L5mYVI=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-15_05,2026-09-15_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 malwarescore=0 priorityscore=1501 suspectscore=0 impostorscore=0
 spamscore=0 clxscore=1015 adultscore=0 bulkscore=0 lowpriorityscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2609040000 definitions=main-2609150285

On Mon, 2026-07-27 at 17:21 -0500, Frederick Lawler wrote:
> integrity_audit_msg() wraps integrity_audit_message() such that
> error codes are hidden by passing an additional parameter to
> integrity_audit_message(). Since this is a wrapper, we can replace
> this function with integrity_audit_message() introduced in commit
> 2f845882ecd2 ("integrity: Add errno field in audit message")
>=20
> No functional change intended.

There's an unintentional change in ima_write_policy(), which replaces the
existing '1' with result.

>=20
> Signed-off-by: Frederick Lawler <fred@cloudflare.com>

Is renaming integrity_audit_msg() to integrity_audit_message() actually the
right approach here?  integrity_audit_message() currently has only 2 caller=
s vs.
~20+ for integrity_audit_msg(), and the rename forces re-wrapping of every
multi-line call site since integrity_audit_message is 4 chars longer, bloat=
ing
the first patch.

Why not simply add errno to the integrity_audit_msg() definition and caller=
s. =20

Patch 1 =E2=80=94 Add errno param to integrity_audit_msg(); update its ~20+=
 existing
call sites with real error values. Purely semantic, needs careful per-site
review.

Patch 2 =E2=80=94 Convert integrity_audit_message()'s 2 callers to integrit=
y_audit_msg()
(now identical signature, trivial rename), then delete integrity_audit_mess=
age()
as dead code. Purely mechanical, trivially reviewable, no functional risk.

thanks,

Mimi

> ---
>=20
> =20
> diff --git a/security/integrity/ima/ima_fs.c b/security/integrity/ima/ima=
_fs.c
> index 2a0bca5543161912abe2a0236c9fcae7055e62bc..a0c1a6dd6a750220b529cc3f7=
7c2ae5673188e11 100644
> --- a/security/integrity/ima/ima_fs.c
> +++ b/security/integrity/ima/ima_fs.c
> @@ -593,9 +593,10 @@ static ssize_t ima_write_policy(struct file *file, c=
onst char __user *buf,
>  		result =3D ima_read_policy(data);
>  	} else if (ima_appraise & IMA_APPRAISE_POLICY) {
>  		pr_err("signed policy file (specified as an absolute pathname) require=
d\n");
> -		integrity_audit_msg(AUDIT_INTEGRITY_STATUS, NULL, NULL,
> -				    "policy_update", "signed policy required",
> -				    1, 0);
> +		integrity_audit_message(AUDIT_INTEGRITY_STATUS, NULL, NULL,
> +					"policy_update",
> +					"signed policy required",
> +					result, 0, 0);
>  		result =3D -EACCES;
>  	} else {
>  		ima_measure_raw_policy(data, datalen);
