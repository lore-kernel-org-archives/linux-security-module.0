Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 23D262DECD3;
	Fri,  4 Sep 2026 20:49:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788554990; cv=none; b=dS2eYEPxgH9LYqbx7/UXXjOOca1G2RPGnj6ovkO/MCu1YWhg3aThY4yxbu8jYNZO8czce5GJ27y0owaob7uIVwWM3OOTeTs67MjRJL9sR+vjqKVfYICMHWEKKFrdPm0QYRbspJSbUFF52rLdh0fBIDl0MYak6ynJTxS2Px9F9xE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788554990; c=relaxed/simple;
	bh=fLqclZjJOQtmDirTwwFNebcgCcsnDTeKSSyYD/nIH3s=;
	h=Message-ID:Subject:From:To:Cc:In-Reply-To:References:Content-Type:
	 Date:MIME-Version; b=KaOtFVdmnDPdk+pKIoomQNwrMMrww49ysGxRzA9Kf/iEFdlI6Mn5zjZg7CWevmQzSLt18gF+BuTCw7npOBeEZE3ivdspUia9maoT/+Bqfzajxsld1agq6ULJ0FNJMVfBnFSF+L4Wy3ABFdbFm5l5oWfFyrRTLGQyNeEys/uRCOk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=ZXtWa6r2; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="ZXtWa6r2"
Received: from pps.filterd (m0353725.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 684HWE7F1237010;
	Fri, 4 Sep 2026 20:49:28 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=3a/VVe
	Mgz/Z8AVgCj6paCuH7nDoK+UBDY9YcKjL78r4=; b=ZXtWa6r2FKrq/1d7ps2YYg
	TWwQTjKt3JqTGbAXtGvdn+i+Eq0IvhuNmJJuy2V/pr+7oXrW7wUsc6QXDz0jPVkp
	GE1nJxFVQfLkuTsAIXd9zA3wwG0jpfbOS6slPdzILp1QD70FDFP3gB/JvOPLLS0E
	qV/ZjdElqW8IliVl+9ooR0oXbTGRHf3cokFJeo3XjYbTHx+ufGBzOQJuZN/HvbiB
	NKgHNblI5BRUeNc9xP5yND4Ums3PYcn18ZMcO/WdeikdiJLTjM5yufiRn9aVdycG
	uvXVZxhFQbnvq4sPuFfwwD870Cfm41PqheDZ3IZ5voEGvgMaufiaTF2PqajbwuGA
	==
Received: from ppma11.dal12v.mail.ibm.com (db.9e.1632.ip4.static.sl-reverse.com [50.22.158.219])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4gbnuecp5s-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 04 Sep 2026 20:49:27 +0000 (GMT)
Received: from pps.filterd (ppma11.dal12v.mail.ibm.com [127.0.0.1])
	by ppma11.dal12v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 684KfnnT002955;
	Fri, 4 Sep 2026 20:49:26 GMT
Received: from smtprelay05.dal12v.mail.ibm.com ([172.16.1.7])
	by ppma11.dal12v.mail.ibm.com (PPS) with ESMTPS id 4gcceyq1fg-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 04 Sep 2026 20:49:26 +0000 (GMT)
Received: from smtpav06.wdc07v.mail.ibm.com (smtpav06.wdc07v.mail.ibm.com [10.39.53.233])
	by smtprelay05.dal12v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 684KnQwX32178828
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 4 Sep 2026 20:49:26 GMT
Received: from smtpav06.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id E45A358055;
	Fri,  4 Sep 2026 20:49:25 +0000 (GMT)
Received: from smtpav06.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id E1FEA5804E;
	Fri,  4 Sep 2026 20:49:24 +0000 (GMT)
Received: from li-43857255-d5e6-4659-90f1-fc5cee4750ad.ibm.com (unknown [9.61.85.196])
	by smtpav06.wdc07v.mail.ibm.com (Postfix) with ESMTP;
	Fri,  4 Sep 2026 20:49:24 +0000 (GMT)
Message-ID: <4d24731cbc3ea3d359a26bb70eb97386f409a988.camel@linux.ibm.com>
Subject: Re: [PATCH v2] ima: allow users to specify the pcr index with
 IMA_MEASURE_PCR_IDX
From: Mimi Zohar <zohar@linux.ibm.com>
To: Julian Braha <julianbraha@gmail.com>, roberto.sassu@huawei.com,
        dmitry.kasatkin@gmail.com, paul@paul-moore.com, jmorris@namei.org,
        serge@hallyn.com
Cc: eric.snowberg@oracle.com, linux-integrity@vger.kernel.org,
        linux-security-module@vger.kernel.org, linux-kernel@vger.kernel.org
In-Reply-To: <20260904110911.4087260-1-julianbraha@gmail.com>
References: <20260904110911.4087260-1-julianbraha@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Date: Fri, 04 Sep 2026 16:49:24 -0400
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Evolution 3.58.3 (3.58.3-1.fc43) 
X-TM-AS-GCONF: 00
X-Proofpoint-Reinject: loops=2 maxloops=12
X-Proofpoint-GUID: dR31GZAr5cAxMmVujybJD0ffFeFkWEUJ
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTA0MDE4OSBTYWx0ZWRfX2r9RSu7/ZvT2
 FhCRxFTf0MlDecN4lAP2ZgomEYPfsueeqT1yLlWwdfq6kep8lOe549/ScnKKps/d4mETeMEGrYT
 ni5powzhuH6smXGUu/12nHBCkmsd9AMKTHax8i1LRMKLrvw7FvL9dt6ajKK/yHYVcBhq8k6HcBg
 MX+OK3iibkgRNaHBaSFD61qyWVFrBcdpBXeBnpnlbpj6lobPp+Q3yG6yKYoAywfiml52KfXJmMG
 G73T2ERAbqEXXbW+QNCMn2XuVddox2gJWrMNB17IvBBv8gwg/pnSB/aPl3FWGbTDAsSM3TnzGbz
 ynFakebkj8XChcLdbXMWZEXxZqk78uY9Li6aYfF/KjLkxGj5JTnMRYuOUT7XBVJFQOQQcfaCJCo
 gKd+HhQIFQ2Utri23C0YqPREfzDvKilHVV4wuHJBbVviorGSKDkx9aDeZPRNeT7uSusQmo8kmC6
 dbkORilOutklx0OeHMw==
X-Proofpoint-ORIG-GUID: j3YBK80ZxH98Glb3_RzBau1hT7YARKN9
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTA0MDE4OSBTYWx0ZWRfX2F3sR7xU0LdL
 0j46xSStDVPAc6NfkFxIZ81dQnwztZ3YGH4y97m7E2OyR4yW/zrOajR4YZWzbS0aabEpwTzhpqz
 FDGTHdJwUOzPIFImqyFFs7YpP/4ghT4=
X-Authority-Analysis: v=2.4 cv=B92JFutM c=1 sm=1 tr=0 ts=6a9b2ed7 cx=c_pps
 a=aDMHemPKRhS1OARIsFnwRA==:117 a=aDMHemPKRhS1OARIsFnwRA==:17
 a=IkcTkHD0fZMA:10 a=VdqzKS8jKosA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=V8glGbnc2Ofi9Qvn3v5h:22 a=VwQbUJbxAAAA:8
 a=pGLkceISAAAA:8 a=K8a6fEQXthkGtAHtFCQA:9 a=QEXdDO2ut3YA:10
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-04_05,2026-09-03_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 adultscore=0 spamscore=0 clxscore=1015 suspectscore=0 phishscore=0
 lowpriorityscore=0 bulkscore=0 priorityscore=1501 impostorscore=0
 malwarescore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2606150000
 definitions=main-2609040189

On Fri, 2026-09-04 at 12:09 +0100, Julian Braha wrote:
> The IMA_MEASURE_PCR_IDX option is currently not visible in the kconfig
> frontend, so it always uses its default, 10. This means that the
> 'range 8 14' is dead code, and users are unable to specify the pcr index
> value.
>=20
> In a previous discussion, Mimi explained that users should be able to use
> this config option to specify the pcr index. [1]
>=20
> Let's add a prompt for users to specify the pcr index, when EXPERT is
> enabled.
>=20
> This dead range was found by kconfirm, a static analysis tool for Kconfig=
.
>=20
> Link: https://lore.kernel.org/all/1feff118-4afa-4b9c-86f1-271a7a88208f@gm=
ail.com/T/#mc4efa2491b4937eb7c9e532c29ffba516a70e662 [1]
> Signed-off-by: Julian Braha <julianbraha@gmail.com>

Thanks, Julian.  The patch is now queued in the next-integrity branch.

Mimi
