Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 164737F492;
	Thu, 11 Jul 2024 17:45:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720719960; cv=none; b=cB1TvAfh53CobLDTfc130YO/fVfSG6nZVANo77/HPZR7QbY23mjUghyabI4cfzFu04oK/bya+E9Kc6ojHqiLTELRXvIEkjrxf5Y+j/BK91Xhl2Eph8zEUaOMOsn8RHZa7xexIgZxUH5oD4MLYawGxRXHrE02l7H8R3reTOdxKrI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720719960; c=relaxed/simple;
	bh=xclbpvZqBZFVNWlZTggHeSBR9i8w8gKEldzknM8mYRo=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=Jg3/7aWY1wJanP7OWTd1FBFV/PfEtZ4LubWI1q7cua79Ah1Ef1UxCtIn3BiMqn+LXe1B4FFGQvqNBKlXlslPRfpDC59BO5Y8eBzwQ6nilgNEwJMReynAPXSnew93zo0amcDrvBDgibe0Xhf9WLZlNx0aKk2q95yOy8sdEB/eCvo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=RYRoACGC; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="RYRoACGC"
Received: from pps.filterd (m0279873.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 46BCih1U014631;
	Thu, 11 Jul 2024 17:45:45 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	GwBFYXMdD1X49TV4BVm7xe3SSQwTysSATv9976M8WMU=; b=RYRoACGCohysQ15e
	w9EJPsz4WSd0Gv9fKb+JkNcG90wZwYeU167EnTZssM9cYWGDN7QiWaJxCivpTPzb
	pB6Jff6E33wPiSIAahhD3GAUc6d/tCeXd6TrI8CLvVgqoog5kBATlgAQYTudsrt4
	GcnKTANgFRIhXUuB23VGPCdIfUollPx2/A3XICefqeApcGRVOyQgeRFGZ6tydLGs
	Np74UJwQpmRhbzj5i12XtHOifHBqGycxUTBW5ddLJ2L3Y/eRVEThrJS/iGXvPQok
	bOSTyC1GhS82ZjLa3WY+G37Qz8hE/xD07tsE4typsistGGy/4N+eDcvP10+9M8l/
	N6uUoQ==
Received: from nalasppmta03.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 409kdtmxrf-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 11 Jul 2024 17:45:45 +0000 (GMT)
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
	by NALASPPMTA03.qualcomm.com (8.17.1.19/8.17.1.19) with ESMTPS id 46BHjiMD009338
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 11 Jul 2024 17:45:44 GMT
Received: from [10.81.24.74] (10.49.16.6) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.9; Thu, 11 Jul
 2024 10:45:43 -0700
Message-ID: <ea1b2ed4-704a-4676-8915-d3e566675070@quicinc.com>
Date: Thu, 11 Jul 2024 10:45:43 -0700
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] apparmor: test: add MODULE_DESCRIPTION()
To: John Johansen <john.johansen@canonical.com>,
        Paul Moore
	<paul@paul-moore.com>, James Morris <jmorris@namei.org>,
        "Serge E. Hallyn"
	<serge@hallyn.com>
CC: <apparmor@lists.ubuntu.com>, <linux-security-module@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <kernel-janitors@vger.kernel.org>
References: <20240529-md-apparmor_policy_unpack_test-v1-1-9efc582078c4@quicinc.com>
 <17dad6b9-9dc3-4b0f-bd3d-34e9e22e7627@canonical.com>
Content-Language: en-US
From: Jeff Johnson <quic_jjohnson@quicinc.com>
In-Reply-To: <17dad6b9-9dc3-4b0f-bd3d-34e9e22e7627@canonical.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: nalasex01a.na.qualcomm.com (10.47.209.196) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: k8Mhs3lXG4xo2MilVXA2DfNYVGINlqP_
X-Proofpoint-GUID: k8Mhs3lXG4xo2MilVXA2DfNYVGINlqP_
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-07-11_12,2024-07-11_01,2024-05-17_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 spamscore=0 clxscore=1011
 impostorscore=0 mlxlogscore=635 lowpriorityscore=0 malwarescore=0
 adultscore=0 suspectscore=0 phishscore=0 bulkscore=0 priorityscore=1501
 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2406140001 definitions=main-2407110123

On 6/25/24 01:26, John Johansen wrote:
> On 5/29/24 18:21, Jeff Johnson wrote:
>> Fix the 'make W=1' warning:
>> WARNING: modpost: missing MODULE_DESCRIPTION() in 
>> security/apparmor/apparmor_policy_unpack_test.o
>>
>> Signed-off-by: Jeff Johnson <quic_jjohnson@quicinc.com>
> 
> Acked-by: John Johansen <john.johansen@canonical.com>
> 
> I will pull this into my tree

I still don't see this in linux-next.
I'm hoping to have these warnings fixed tree-wide in 6.11.

