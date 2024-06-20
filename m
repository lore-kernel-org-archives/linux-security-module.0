Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B58381CD3D;
	Thu, 20 Jun 2024 16:22:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718900536; cv=none; b=SSYoHxH+S4wLaC4W1oZbHBm+lWo+IHbaz9D8WK7kjeOuGm/3M2UOCi7hqgecobEC7Xyp7UTJ9Mtgml1nLujacPcB3f+BJk5FdihztplvXypJjpepzrbOD+siCVIWHUU4RBxihNO77F6SyltbrcdBL0ge7FGa7KBOdDuTU0lGhe8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718900536; c=relaxed/simple;
	bh=ssJliKc5kNtUyUtknPdOclEvUOLH+104ZebK/uc38CI=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=F7ORG2kyXxrEGOGi0ttBjkaw8J0c0ViWFsqX4USSdKmBJE4Uh3+43RGFSTqjXw87ZLvN2WEDZzKeKDlTSXY+9p2lPH/wsxOrrwqIbgNdOTPK7cTzTWrmw24AAfhyZnDxc9X6YFfwc9x9NKX2d4dfGNJvSY3Zr9j8Rq7+w9DmejA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=jOx7eYfG; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="jOx7eYfG"
Received: from pps.filterd (m0279872.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 45K9vXRa003612;
	Thu, 20 Jun 2024 16:22:02 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	hhGpsxMxzPNoapl7cqpvoCRjNe/ydCSjVn5o6h1MEu0=; b=jOx7eYfGaCbY5pPh
	PU+XzdAGyBjuNJh9BhWB6mHmDbc8ETjF3tIBCJI+nJwNgWu8LV1cvgxI1z6jHMLr
	GkpETrTgkA7Dw/XMf3WueG88YxPtraRbz1NlUmoRtGYSamfdEfmXV1OWyT42O0C3
	V+bRn0ChDOkdPRA4kaB0tgE4l/sxVgn8TqneiplzztakibGkDALk8es/KgU6YTBK
	i0qg4G1deu6wbcTzaoJRQ35BUkU5JJhyvDLRV1gjEh2eIpmHW64qL5VljiF5yGc7
	fav6XDU2IMgtWcgwzAW6Xll1fZvSZyQpjhf/bd8t1MDYQo1Vz0yNwn5pmuKmSLl8
	EuaDmg==
Received: from nalasppmta03.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3yvaqbswx4-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 20 Jun 2024 16:22:01 +0000 (GMT)
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
	by NALASPPMTA03.qualcomm.com (8.17.1.19/8.17.1.19) with ESMTPS id 45KGM0XL001765
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 20 Jun 2024 16:22:00 GMT
Received: from [10.48.244.93] (10.49.16.6) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.9; Thu, 20 Jun
 2024 09:21:59 -0700
Message-ID: <66425403-66fc-4250-9642-5b29dc821b39@quicinc.com>
Date: Thu, 20 Jun 2024 09:21:59 -0700
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] apparmor: test: add MODULE_DESCRIPTION()
Content-Language: en-US
To: John Johansen <john.johansen@canonical.com>,
        Paul Moore
	<paul@paul-moore.com>, James Morris <jmorris@namei.org>,
        "Serge E. Hallyn"
	<serge@hallyn.com>
CC: <apparmor@lists.ubuntu.com>, <linux-security-module@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <kernel-janitors@vger.kernel.org>
References: <20240529-md-apparmor_policy_unpack_test-v1-1-9efc582078c4@quicinc.com>
From: Jeff Johnson <quic_jjohnson@quicinc.com>
In-Reply-To: <20240529-md-apparmor_policy_unpack_test-v1-1-9efc582078c4@quicinc.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: nalasex01a.na.qualcomm.com (10.47.209.196) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: 9ntzmUJzd46cMdm1GDexHpmHrfFSoAvk
X-Proofpoint-ORIG-GUID: 9ntzmUJzd46cMdm1GDexHpmHrfFSoAvk
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-06-20_07,2024-06-20_04,2024-05-17_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 spamscore=0 clxscore=1011
 lowpriorityscore=0 bulkscore=0 phishscore=0 mlxlogscore=999
 priorityscore=1501 malwarescore=0 mlxscore=0 adultscore=0 suspectscore=0
 impostorscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2405170001 definitions=main-2406200118

On 5/29/2024 6:21 PM, Jeff Johnson wrote:
> Fix the 'make W=1' warning:
> WARNING: modpost: missing MODULE_DESCRIPTION() in security/apparmor/apparmor_policy_unpack_test.o
> 
> Signed-off-by: Jeff Johnson <quic_jjohnson@quicinc.com>
> ---
>  security/apparmor/policy_unpack_test.c | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/security/apparmor/policy_unpack_test.c b/security/apparmor/policy_unpack_test.c
> index 5c9bde25e56d..874fcf97794e 100644
> --- a/security/apparmor/policy_unpack_test.c
> +++ b/security/apparmor/policy_unpack_test.c
> @@ -604,4 +604,5 @@ static struct kunit_suite apparmor_policy_unpack_test_module = {
>  
>  kunit_test_suite(apparmor_policy_unpack_test_module);
>  
> +MODULE_DESCRIPTION("KUnit tests for AppArmor's policy unpack");
>  MODULE_LICENSE("GPL");
> 
> ---
> base-commit: 4a4be1ad3a6efea16c56615f31117590fd881358
> change-id: 20240529-md-apparmor_policy_unpack_test-7657c4f11591
> 

Following up to see if anything else is needed to get this merged.
