Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0E3453AD518;
	Fri, 24 Jul 2026 20:34:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784925274; cv=none; b=EO2Q/O5fv9pYZOxYnaqU8Ps9TGhTxJ/LcNbComwigzhNI1NvdN97aHVvJseMeagAsxeF8wATiKu5uKr+ejiUIL9AhCuywRmd6CypFOm8q3AX2us0DinyTAsHfuXB4PXobZbgmDPxHlOuWBIn0bZF1bD0YmVfhd2kTSi3ubWBt4A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784925274; c=relaxed/simple;
	bh=7Q2FunL2zNINppw/onu0/dbeh32KX2022MrWeVX3Pho=;
	h=Message-ID:Subject:From:To:Cc:In-Reply-To:References:Content-Type:
	 Date:MIME-Version; b=PrZKSn2PY79ukJF8qY94GnGLdseih45qW/zdZsEAmW4Ypwrdq/dPYS3g/FB30AEBdtdy5kbyzwypcjeE5lVYhfUXOeEPpoF603Y2dA9LQvJbcKYanYjTTFHoLRUfaEMSRMsKZvlv+yTTsG4pXZduUC8ol76go1AN6YnFFtTNYRk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=N2RrOABI; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="N2RrOABI"
Received: from pps.filterd (m0360083.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 66OHC3ql2430310;
	Fri, 24 Jul 2026 20:34:11 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=A3OFwZ
	M5k45gyysQenFNR0jCkEUqtQzp06ETic4R/0Q=; b=N2RrOABIsDltb4j9siC0OR
	dbGzx+0wg7OFHx/Z3CAoskT/5y7Qocqw+mR2YqRKOG1aBcnu52Vt7LGB1UPiCYoN
	hov/35PQikMS5GQhNwe0n2Mg1zC1PqjPGaZ7+Fq4sEj4VniW4PgyZ8mB/NreR7HG
	TKwUXMYAli/4solOsKUY+2k6Qx2wGyl8CtE5Xi3xHQwAFRCaWqWLmb/WvGcppEU4
	kzX8/iftdFibKCSL3APwNQ5PK/HLsDimHPCcLtLGwdsh+A7zwy2Cfy8nOFlaRgE8
	3lpTulgs0CEEgWsJ9VJ31rCHm1H+qPZM+Qi4l2Tz0SVzCO7/AqK02JWvsfki6VZg
	==
Received: from ppma22.wdc07v.mail.ibm.com (5c.69.3da9.ip4.static.sl-reverse.com [169.61.105.92])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4fm8h51vx3-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 24 Jul 2026 20:34:11 +0000 (GMT)
Received: from pps.filterd (ppma22.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma22.wdc07v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 66OKJcKL010447;
	Fri, 24 Jul 2026 20:34:10 GMT
Received: from smtprelay06.wdc07v.mail.ibm.com ([172.16.1.73])
	by ppma22.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4fgm6wjp87-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 24 Jul 2026 20:34:10 +0000 (GMT)
Received: from smtpav05.dal12v.mail.ibm.com (smtpav05.dal12v.mail.ibm.com [10.241.53.104])
	by smtprelay06.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 66OKY99c066088
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 24 Jul 2026 20:34:09 GMT
Received: from smtpav05.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 65DA658065;
	Fri, 24 Jul 2026 20:34:09 +0000 (GMT)
Received: from smtpav05.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 970BA58052;
	Fri, 24 Jul 2026 20:34:08 +0000 (GMT)
Received: from li-43857255-d5e6-4659-90f1-fc5cee4750ad.ibm.com (unknown [9.61.189.235])
	by smtpav05.dal12v.mail.ibm.com (Postfix) with ESMTP;
	Fri, 24 Jul 2026 20:34:08 +0000 (GMT)
Message-ID: <6e6642c14477e409ea34a6090a61cde7f00934fd.camel@linux.ibm.com>
Subject: Re: [PATCH] ima: Report errno for failed hash collection to audit
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
In-Reply-To: <20260716-report-hash-error-v1-1-ac19281112e4@cloudflare.com>
References: <20260716-report-hash-error-v1-1-ac19281112e4@cloudflare.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Date: Fri, 24 Jul 2026 16:34:07 -0400
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Evolution 3.58.3 (3.58.3-1.fc43) 
X-TM-AS-GCONF: 00
X-Proofpoint-Reinject: loops=2 maxloops=12
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzI0MDE4MSBTYWx0ZWRfX5dmNLBCYnREY
 fIoYFAy0E86d1AqI11Fq4zr93wlXnDJ1rdMJ60uNVjnSxIrGhoHSYGQ+4Hu0foHqwP+BkgLnKWt
 5qAJOGdRLQWYrcuAU+NR7SqNP8J5IpM=
X-Proofpoint-ORIG-GUID: qTMBVx4-BnUzpNNPBEsjanCteMj253ge
X-Proofpoint-GUID: 31Lu9-SBWeZ7D4GqfwbYn5ULfTIrnP7n
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzI0MDE4MSBTYWx0ZWRfX1ycBejSc86RK
 WjRN/ODmHqCCI/HezLka0rYaW0e0H4Yq0dDBK8wQ1exjfDs3WEQxr/18IoWCOZG5WCEC4CBTnw6
 YhdD2DLk+iVd8qpIDbdjLXEdjmGh1/IiiIFF4cNS9ULyJaJV4/QSDUvmBtatosXyowMRb+adA5w
 PvJ8dq2axiXDZdkjRQAyC8rFL+8IKQrF6nJuO6NapYJ4gUgj3O9k86pIT2jqerHFszfGJPgTP5u
 DY5fbYVBgDj9c69v7aS3TY661Lh6Jlgx4lEdecCpaFy8ieT1hojDvflhsopSpk0B5M+KO5I4W0d
 c56QDr2sJhA9Lt6xsLqP3Qu0yEESe5PLYKscd1vuiq167co6lkqTEvPkbL2FUD1d3fAjiTbABzY
 0yXSha2qmbM6PlZhtQ+liI6eIg+2bHosjkryxugUNWabtuZTEPerofyKF3bqF08eP5/gobSFDmw
 iFVDh336TQypL/HTFRg==
X-Authority-Analysis: v=2.4 cv=du3rzVg4 c=1 sm=1 tr=0 ts=6a63cc43 cx=c_pps
 a=5BHTudwdYE3Te8bg5FgnPg==:117 a=5BHTudwdYE3Te8bg5FgnPg==:17
 a=IkcTkHD0fZMA:10 a=RAioF0-LDSMA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=iQ6ETzBq9ecOQQE5vZCe:22 a=EG7W4yiQAAAA:8
 a=ed0vf8S_Dfqsh71IS7UA:9 a=QEXdDO2ut3YA:10
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-24_04,2026-07-24_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 adultscore=0 clxscore=1011 malwarescore=0 spamscore=0 impostorscore=0
 phishscore=0 bulkscore=0 priorityscore=1501 lowpriorityscore=0 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2607240181

Hi Frederick,

On Thu, 2026-07-16 at 14:10 -0500, Frederick Lawler wrote:
> integrity_audit_msg() wraps integrity_audit_message() such that errno is
> always set to zero. When debugging for failed hashes, it'd be nice to
> understand the corresponding error code with the cause.
>=20
> Signed-off-by: Frederick Lawler <fred@cloudflare.com>

This patch looks fine.  Any chance you have time to look at the remaining I=
MA
calls to integrity_audit_msg() and fix them as well?

thanks,

Mimi
