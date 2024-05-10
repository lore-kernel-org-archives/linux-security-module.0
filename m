Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7BEF01D530;
	Fri, 10 May 2024 19:01:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715367702; cv=none; b=hxxCKBxGUscMwWeQpqKoBErS742wT7l582u0um0ARWQd+/vGn7+f0dja7FX7VeXpMbJh/0ohLg31ObC4E6gWndvNsft0d4slXJ46uIvvaClz+Y5+C6YjMI92DV60d42vIoVcyXP9CQwSuFi1gGN9W6SzIitJG+kZYH+0UtFD9bI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715367702; c=relaxed/simple;
	bh=XeeS+V2EqO/KopPFay6n7ImHw9WGyCeLggw8KzbASF8=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=rLsE3Hlo6k/tQFPToXLOqAr+Gf4TOCGMIqlbZQzJFARqTYQ6G/0lhjTobHa4JnWnFOdqpdxMNwikYdQMMaKqqlT631bV6IV8Zp2GgiB+rXOpxANUIT5LdQsAFhrvGPUbjzI21PKBHxsxJxAPIWN/eDm2BffYGITm5wjDEmeWc0c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=mjSDBavr; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="mjSDBavr"
Received: from pps.filterd (m0279863.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 44AE9J3K003598;
	Fri, 10 May 2024 19:01:25 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	message-id:date:mime-version:subject:to:cc:references:from
	:in-reply-to:content-type:content-transfer-encoding; s=
	qcppdkim1; bh=dluej5QdfgvNr84cn+9rIFxXbFP9hKdWdTu2yovfVGI=; b=mj
	SDBavrHR23sEVboBySmujbxOj6skbEcbH0Ffw65fJy7tMPSyoQeus1BkA2NZLnzh
	8MAKTq7bnq+ZCDPo48jiPhvv4j40Wn+BadHGcWs1ybKHqrBt76akbb7bpYVWez9u
	CBmBLQCbq2uj+xM0Eaog555S/tcVrRkyt7ZsV6YxTiw0I6jF+8B1HoKgS0ikgTD8
	pT3oXasU0UrOX0/iOvFBcNXEOaTkT/aC5lcFnN9hyru5HFjUrxd+whjLk/eKPCGl
	rkpqfuIfjBPfPMce5u9LbfNaGB2DZE+SdQdcKkUd+5a+9CdnzpwEd5NSbe/E8bkQ
	VEu0xl+4eN4nXDh0T1Rw==
Received: from nalasppmta01.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3y16w12c70-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 10 May 2024 19:01:24 +0000 (GMT)
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
	by NALASPPMTA01.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 44AJ1OuA019306
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 10 May 2024 19:01:24 GMT
Received: from [10.110.100.57] (10.80.80.8) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.9; Fri, 10 May
 2024 12:01:23 -0700
Message-ID: <efaf1b74-824c-4039-9f6b-47c68c4e2a1d@quicinc.com>
Date: Fri, 10 May 2024 12:01:22 -0700
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] apparmor: fix apparmor_socket_post_create() kernel-doc
Content-Language: en-US
To: John Johansen <john.johansen@canonical.com>,
        Paul Moore
	<paul@paul-moore.com>, James Morris <jmorris@namei.org>,
        "Serge E. Hallyn"
	<serge@hallyn.com>
CC: <apparmor@lists.ubuntu.com>, <linux-security-module@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
References: <20240505-apparmor_socket_post_create-kdoc-v1-1-1fd88e546e92@quicinc.com>
 <00107f4f-9a14-43b0-8204-45978a487e33@canonical.com>
From: Jeff Johnson <quic_jjohnson@quicinc.com>
In-Reply-To: <00107f4f-9a14-43b0-8204-45978a487e33@canonical.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: jNnYhDSs0YE9nY42R83t8jtrlZV5OFn_
X-Proofpoint-ORIG-GUID: jNnYhDSs0YE9nY42R83t8jtrlZV5OFn_
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.650,FMLib:17.11.176.26
 definitions=2024-05-10_14,2024-05-10_02,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxscore=0 lowpriorityscore=0
 clxscore=1015 malwarescore=0 mlxlogscore=778 adultscore=0 suspectscore=0
 impostorscore=0 phishscore=0 bulkscore=0 priorityscore=1501 spamscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.19.0-2405010000
 definitions=main-2405100136

On 5/10/2024 8:58 AM, John Johansen wrote:
> On 5/5/24 15:39, Jeff Johnson wrote:
>> make C=1 reports:
>>
>> security/apparmor/lsm.c:1138: warning: Function parameter or struct member 'protocol' not described in 'apparmor_socket_post_create'
>>
>> Fix this by correcting the misspelling of 'protocol'.
>>
>> Signed-off-by: Jeff Johnson <quic_jjohnson@quicinc.com>
> 
> Hey Jeff, thanks for the patch, unfortunately Christian Göttsche version of the patch came in before yours so that is the one I committed

np, glad others are helping to clean up :)
