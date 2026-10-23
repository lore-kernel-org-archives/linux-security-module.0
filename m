Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=148.163.158.5
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792777031;
	b=hm5dK/dhbtXTCqK8C6dEfbYdH85csz9Y6J88YCsvRAEXE1Qs/n0+JVdWUhetQOrGcim5
	 YUIklRmc+bi86ygsf8/ZWgw1DsFMLnBs2Vga6k38PhnSMlE8V8iN+GeoXdmI2H7G18Ka4
	 BG1vdhKTZXLantGlhDakQopJ9vltaTxQn5RF8Q/mFhd/X4WqVx4C+GzCnNGSmzOCZpe6x
	 epQap04xmQM9syBACBeDIWg0bq8jovS97CrkwIfw/yBFxVATHgRYZ50+162V6zQsLFC8g
	 9wNJL8LoI+RHVM9HDspNW3qwoipXhFCF1Rfi5jzVstMue8WtB6WyuQ79DE7Yy/ePoNg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792777031;
	h=DMARC-Filter:Received:DKIM-Signature:Received:Received:Received:
	 Received:Received:Received:Received:Message-ID:Subject:From:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date:
	 MIME-Version:User-Agent:X-TM-AS-GCONF:X-Proofpoint-Reinject:
	 X-Authority-Analysis:X-Proofpoint-ORIG-GUID:
	 X-Proofpoint-Spam-Details-Enc:X-Proofpoint-Spam-Info:
	 X-Proofpoint-GUID:X-Proofpoint-Virus-Version:
	 X-Proofpoint-Spam-Details;
	bh=4lrUHgigAU7t4jU4wOsI7FGddN6psw/EiYbWIPfZgcY=;
	b=cwyxxVMBG6Z4IVfFj8TvasW4juP8k8xPvrIVm1OHh/CUa3Nl88WA/vslEQ2+BV1r9x/4
	 hbwS6iJVWjZ040QFPuVIKtImEnCSTfWwlKCFx7UNaLNmuj3Zem/wrgrzbJLw5iKG5wVBb
	 /x5tXnlW5bB+OQn0rdIDJG/cdYazLwv7sUV2gyNHs43SuPsTmN9D+aSNu7hmF2MDB5Wa8
	 ZoL3mlfhFR95h8hwm4tbLMS+rbMZygVmBKf61wo7oJ826fjGNqL9HhQGS/4nJ5ijA2D9B
	 fuFbi4NzgDNvRdamIGAPBX4HdCMyEhzr97CLIF3ziDaWNGITYC+3z1fPTl7aat8Hb6Q==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=linux.ibm.com;
	spf=pass smtp.mailfrom=linux.ibm.com;
	dkim=pass header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=lDy6mSgE;
	arc=none smtp.remote-ip=148.163.158.5
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EFEAB606A332;
	Fri, 23 Oct 2026 17:37:10 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org EFEAB606A332
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=lDy6mSgE
Received: from pps.filterd (m0356516.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 69NGqAfa3495798;
	Fri, 23 Oct 2026 17:36:19 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=4lrUHg
	igAU7t4jU4wOsI7FGddN6psw/EiYbWIPfZgcY=; b=lDy6mSgE6M81vAyyVwTsFQ
	ilOrUFhtcQBqDxKJaBItFFCsrE9EAZVHogTG1mqWL6pZ/T5OotCbkNrY4OnI3WOo
	FvtYtvGmXE0Znbgomlfgb150Fji5tO3Lg4ft75X1xACdlIzV6Hf1hDz3VdOwsUgG
	9CPLn2qMtKtDoDsXVHD4N1qA/Wu4Mpd5c7uxhVG1wGxnN9ZWK1eNpCB2hr3752LO
	/Glq/U4aY7CC608Hs7pi+Y1nPc688e6h1MEguRiq3ovRKkVWRjafDmqXHeDpWTlO
	vJv080YQ5jhc5LxLT7Gp0IB7I8pEAP/iF7CYnzKFUY3vh8/DCSMDVIVkUoLeIenw
	==
Received: from ppma22.wdc07v.mail.ibm.com (5c.69.3da9.ip4.static.sl-reverse.com [169.61.105.92])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4hdw5b60g6-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Fri, 23 Oct 2026 17:36:19 +0000 (GMT)
Received: from pps.filterd (ppma22.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma22.wdc07v.mail.ibm.com (8.18.1.11/8.18.1.11) with ESMTP id 69NEL7st2203391;
	Fri, 23 Oct 2026 17:36:18 GMT
Received: from smtprelay07.wdc07v.mail.ibm.com ([172.16.1.74])
	by ppma22.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4hekdgn63w-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 23 Oct 2026 17:36:18 +0000 (GMT)
Received: from smtpav06.dal12v.mail.ibm.com (smtpav06.dal12v.mail.ibm.com [10.241.53.105])
	by smtprelay07.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 69NHaIC826477258
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 23 Oct 2026 17:36:18 GMT
Received: from smtpav06.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id E520258043;
	Fri, 23 Oct 2026 17:36:17 +0000 (GMT)
Received: from smtpav06.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 6EF9158059;
	Fri, 23 Oct 2026 17:36:17 +0000 (GMT)
Received: from li-43857255-d5e6-4659-90f1-fc5cee4750ad.ibm.com (unknown [9.61.71.77])
	by smtpav06.dal12v.mail.ibm.com (Postfix) with ESMTP;
	Fri, 23 Oct 2026 17:36:17 +0000 (GMT)
Message-ID: <9336bd484bcd0af6e9c88b7b546434e5081ab449.camel@linux.ibm.com>
Subject: Re: [PATCH v3 2/2] ima: audit failure to supply detached data for
 modsig
From: Mimi Zohar <zohar@linux.ibm.com>
To: =?ISO-8859-1?Q?J=E9r=E9my?= Jean <Jeremy.Jean@oss.cyber.gouv.fr>,
        Roberto Sassu <roberto.sassu@huawei.com>,
        Dmitry Kasatkin
 <dmitry.kasatkin@gmail.com>
Cc: Eric Snowberg <eric.snowberg@oracle.com>, linux-integrity@vger.kernel.org,
        linux-security-module@vger.kernel.org, linux-kernel@vger.kernel.org
In-Reply-To: <20261021210145.1851396-5-Jeremy.Jean@oss.cyber.gouv.fr>
References: <20261021210145.1851396-2-Jeremy.Jean@oss.cyber.gouv.fr>
	 <20261021210145.1851396-5-Jeremy.Jean@oss.cyber.gouv.fr>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Date: Fri, 23 Oct 2026 13:36:17 -0400
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Post: <mailto:linux-security-module@vger.kernel.org>
List-Help: <mailto:linux-security-module+help@vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-security-module+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
User-Agent: Evolution 3.58.3 (3.58.3-2.fc43) 
X-TM-AS-GCONF: 00
X-Proofpoint-Reinject: loops=2 maxloops=12
X-Authority-Analysis: v=2.4 cv=X63Hu2Te c=1 sm=1 tr=0 ts=6adb9b13 cx=c_pps
 a=5BHTudwdYE3Te8bg5FgnPg==:117 a=5BHTudwdYE3Te8bg5FgnPg==:17
 a=IkcTkHD0fZMA:10 a=660iZSQnnn4A:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=Y2IxJ9c9Rs8Kov3niI8_:22 a=GaSaRxANBN9W-jNe9hgA:9
 a=QEXdDO2ut3YA:10
X-Proofpoint-ORIG-GUID: OrV3gAhpVpIG-PKFR9LnFV8kpeTb4ZUT
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDIzMDA2NyBTYWx0ZWRfXwxp/vzOpJTCf
 e7nwaMF1cblMr/ub8qjblSYklg1NAevh4u2F5ovAMw/C34RGP/M5Pm+aFDRPjB0FmmdFPg5VB/d
 u1sIGxou15WyB4vgjaaUGrV3qqwPxp6ciNoWDcZJHZDuRFpjHssVoFrAzDl9nYBwFxSixz+Homu
 XJCm7viG++cfqXZhz7NfHBVfio9+joBlrkJcCPLaIpJzMvU4JbmX2aN8E5cB7+WjK2JyhXOwdnX
 9gHsYx0a2yru9DnhIIVXS3Vk7ATm/t/iRVfT/2Zz91rSGabQ9jUDwpKfG2edJvody1cvVE/jLjy
 b1TG2LCwTgXIGRUfgfEAX9UGJksIgDW1+WcXESVioRU8dRRQMI8n5bvxeQHvppwkJFiqzC7QRAN
 XGyZfEQX0nZ8KJKkaAlFHZTJiiIShCNHB5vX3teuWUcWAdCvtnggWeqPYEhLggOffMy4CD9d4pf
 y2gXb8ZIK3mfpo1QOXA==
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDIzMDA2NyBTYWx0ZWRfX3OTOR6VGcpHO
 /ZiutZ6P2g7TJp9lg8WEGUGyBTovVcLdjnRgTPXH38FIgLfqcGDwUCKgdb5TpZWLnHlEEAG2uaf
 n+Dp55d1a7jEj0gMZS+E2tZrP7cXxec=
X-Proofpoint-GUID: qVbbx57hl5ozePcaZYpVDWpH0aEliLsL
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-10-23_04,2026-10-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 phishscore=0 bulkscore=0 adultscore=0 malwarescore=0
 clxscore=1015 spamscore=0 impostorscore=0 lowpriorityscore=0 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2610190000 definitions=main-2610230067

On Wed, 2026-10-21 at 21:01 +0000, J=C3=A9r=C3=A9my Jean wrote:
>=20

> @@ -326,15 +329,20 @@ int ima_collect_measurement(struct ima_iint_cache *=
iint, struct file *file,
>  	if (!result)
>  		iint->flags |=3D IMA_COLLECTED;
>  out:
> -	if (result) {
> +	if (result || modsig_result) {
>  		if (file->f_flags & O_DIRECT)
>  			audit_cause =3D "failed(directio)";
> =20
>  		take_dentry_name_snapshot(&filename, file->f_path.dentry);
> =20
> -		integrity_audit_msg(AUDIT_INTEGRITY_DATA, inode,
> -				    filename.name.name, "collect_data",
> -				    audit_cause, result, 0);
> +		if (modsig_result)
> +			integrity_audit_msg(AUDIT_INTEGRITY_DATA, inode,
> +					    filename.name.name, "collect_data",
> +					    "failed-modsig", modsig_result, 0);
> +		if (result)
> +			integrity_audit_msg(AUDIT_INTEGRITY_DATA, inode,
> +					    filename.name.name, "collect_data",
> +					    audit_cause, result, 0);


Frederick Lawler's patch updated integrity_audit_msg() to include errno.  T=
hese
calls need to be updated.

Mimi

> =20
>  		release_dentry_name_snapshot(&filename);
>  	}
