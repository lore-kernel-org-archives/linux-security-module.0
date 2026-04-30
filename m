Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ABCBF2EDD70
	for <linux-security-module@vger.kernel.org>; Thu, 30 Apr 2026 21:30:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777584643; cv=none; b=GTrEOvG96sVXfJFLSMjCR+62tQrS0Ki48qdsxZ3yG2f8JhMZi/IICHq+GaJIAR10wffu8BFs7+3vgelNICLr9BzPM/BX43cnYgljBvwNxUFELwuk0Mz7idACaI4peRvGqRq1bORtJv9J96Fpy81UROZ0ziLIPUmF7eriQnyK8L4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777584643; c=relaxed/simple;
	bh=ZrM6lFX2UCFPg5Kjyem9LHqjHIVlenZXidp39hyYm1w=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=Epio1h88f1/lM7AldY0eIZu4VWsMaRv0uGXD7v/6o8yb7vaemGDU+MMSRw4hHODop5ZJynN9nRjg2IEBWf1vmGLrgOUfTexjN8TMLpcH+Q3BuswPs4Sek64LOklZLJ/Jo5iwW7D659rtT6GgUpLTHsvgbQJKIbBuY+wCs7vkmIM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=GwRk+e9C; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=UeV+B5Nq; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="GwRk+e9C";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="UeV+B5Nq"
Received: from pps.filterd (m0279864.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 63UGIchD2121658
	for <linux-security-module@vger.kernel.org>; Thu, 30 Apr 2026 21:30:41 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	EYg1mHZ78qeUHVxwPW5soi9NfELbaGNPD7XescIFQxE=; b=GwRk+e9C/NctBONv
	CIKu36r0sw9XwAGbMoUqHqk8F3VsXA1Z1IX+hsOk3wgNN/JYTVQvbelDoTs3yzuo
	w8ezTKWH7Cya2BXuC44TAdPlRU8SQmaJcMNXiKYwjOFvyRGDKVQfv7I2qgynfWTY
	r3EApPmP70ekVWgvhzJfgC6bVqHdGWbty3vae3lGMFqfi8tOR8I2JqlQts85BqhM
	8out9exLsmmNUug79lT5bf9BYWkq6CJsA+vrOol8mk12K5q2bS7qoM5EkB+ewhcY
	Vr6TDrt5AHoCmUfADKd0AGe5/EbNQ87zJKvejDFn3FAwN2iZke4/njr9CTXoUrl3
	5870vQ==
Received: from mail-dy1-f199.google.com (mail-dy1-f199.google.com [74.125.82.199])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4dvag4sc4p-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-security-module@vger.kernel.org>; Thu, 30 Apr 2026 21:30:41 +0000 (GMT)
Received: by mail-dy1-f199.google.com with SMTP id 5a478bee46e88-2ddd8ef5343so1448435eec.1
        for <linux-security-module@vger.kernel.org>; Thu, 30 Apr 2026 14:30:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1777584641; x=1778189441; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=EYg1mHZ78qeUHVxwPW5soi9NfELbaGNPD7XescIFQxE=;
        b=UeV+B5NqiCZ/BrFv0CvfbpPzVZQ86lsYxKf4hOOSM5SIVWZtzfUI6P5HqNvtbyG/rB
         agi/3g6jUssY+cpiirMKM+luydqqrlO49iEDyQqXj/ein/yWTUFJz2cG0MGDg4M6NXrJ
         ZVU3MnU8ls1A2DKFZaf52TzwZBci8k9zscVKvViafw5abb0BV4IBECuQShC7nF3f3H9T
         rs6lj02yBk/bSSGL/02yoPaR18wVY7bZXdEAuIwemUDcjs3mFR8P2Ko5RQfrzC+AgZ6/
         GxdPGT30+zPeMYFx4cUhfVvBXcp2kGCEu1JKbKIJIkzEIJ/UWa9vSsZRoytmto3PWAvH
         qvaQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777584641; x=1778189441;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=EYg1mHZ78qeUHVxwPW5soi9NfELbaGNPD7XescIFQxE=;
        b=CpZkxvxLOuwzDWBhQbGrnT8bJ2q8w0vssXoSzmadQwwz92+uMVe8j0O/uf93xpk00w
         7fCcSAyeS5r9gHMiNoq5ml0dRZtjSt3OorJo0MORawMrQ8pCd1sDBEh2ybqcYgvYZdEi
         pp8tMUzDnLgB/cU5lCJ5DvH0OaP97RXK/VGdmcUUnAuMMMOFv97KOgWl3fKCAb4HV/rJ
         yWkUhpehGI1wjyBo/BPo7+zIMMMPPxGKI54qXE9sxIx/UX3ZX4XoFPs0zJc/ijTOSGcs
         C344jTIwuqZLvyC4p+SQoHaEvy6ES4Bem1OJHJSj9z6zw2HUVqaGz5sVoLAv9BnOf57I
         L0vQ==
X-Forwarded-Encrypted: i=1; AFNElJ/ssc2zvKK4ZDZn+rg1hfJCmNBBsLNhhAKa/sFPV+PRtBtGLZ45bzqXg4X5D12hLFjn7WQ1iy/oh+lhcm6UFeH6UL/6E9g=@vger.kernel.org
X-Gm-Message-State: AOJu0YzRAuGROhCko6ULAoCcw2paV1LbiTIW0xqEXw/JcqsaF8k/SQ2i
	rnjiZuwxPS0Uc8jZnedw24TrapzXQfFKTBYa31/E8/d1wfRlEgjGreBrBg+Y9PYQXx1U5FZTAeW
	qf0yU5+OVpp5iOWQdcbnVLbrqYs2rgFIh9lyqSE2vy2XygCl21jd20yK+WrK6GSyASl0IlqjkXA
	UB6+Y=
X-Gm-Gg: AeBDievbO7rFD/P3v6quwCOg4i5gyjjDOrmI/07lp7f60/ig+nsk+cPq2HBNLMhMxG+
	jlk9AO7U4ot2mJNzjmGqb2TZXotahJvXBheY/mgHHd0cByHyc8epTJbOst/2NXG3iNmyWDdOCum
	UX2tdDgcNuIfbc6UWN77SskL6SfMmWdD80IZOeJ7p8rl+tANt2u8EA1elO9tc5U07oN9w1mfbSN
	7oc+XfStODRPsoSxWyXQyvB9XVqx53P0e7KqLsW9yJFOGP1JMs6eqp3WaC10Of+AHmaSzWPdD3e
	WUXCSsiBj9TiHyki0iIQVWnRVLbETuGx7J0CTaeKZzJVLMNcphNrLLfHdMktqn49Bx3vVbY4LrW
	EzEovCThEX4BqdDBU9MvmGKhwEgmaoP9vmlq49qZPJ5PsJ/PPxJahU4R0AylKjuBcL172iSuty1
	DV4rHgJe5qJnw=
X-Received: by 2002:a05:7300:e402:b0:2dd:6937:79d5 with SMTP id 5a478bee46e88-2ed3d5c6b8fmr2496720eec.8.1777584641153;
        Thu, 30 Apr 2026 14:30:41 -0700 (PDT)
X-Received: by 2002:a05:7300:e402:b0:2dd:6937:79d5 with SMTP id 5a478bee46e88-2ed3d5c6b8fmr2496677eec.8.1777584640462;
        Thu, 30 Apr 2026 14:30:40 -0700 (PDT)
Received: from hu-jjohnson-lv.qualcomm.com (Global_NAT1.qualcomm.com. [129.46.96.20])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-2ee38d79eb9sm2504861eec.8.2026.04.30.14.30.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 30 Apr 2026 14:30:39 -0700 (PDT)
From: Jeff Johnson <jeff.johnson@oss.qualcomm.com>
To: tj@kernel.org, tony.luck@intel.com, jani.nikula@linux.intel.com,
        ap420073@gmail.com, jv@jvosburgh.net, freude@linux.ibm.com,
        bcrl@kvack.org, trondmy@kernel.org, longman@redhat.com,
        kees@kernel.org, pengdonglin <dolinux.peng@gmail.com>
Cc: bigeasy@linutronix.de, hdanton@sina.com, paulmck@kernel.org,
        linux-kernel@vger.kernel.org, linux-rt-devel@lists.linux.dev,
        linux-nfs@vger.kernel.org, linux-aio@kvack.org,
        linux-fsdevel@vger.kernel.org, linux-security-module@vger.kernel.org,
        netdev@vger.kernel.org, intel-gfx@lists.freedesktop.org,
        linux-wireless@vger.kernel.org, linux-acpi@vger.kernel.org,
        linux-s390@vger.kernel.org, cgroups@vger.kernel.org
In-Reply-To: <20250916044735.2316171-1-dolinux.peng@gmail.com>
References: <20250916044735.2316171-1-dolinux.peng@gmail.com>
Subject: Re: (subset) [PATCH v3 00/14] Remove redundant
 rcu_read_lock/unlock() in spin_lock
Message-Id: <177758463946.1848985.4916088351427792183.b4-ty@oss.qualcomm.com>
Date: Thu, 30 Apr 2026 14:30:39 -0700
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.14.3
X-Proofpoint-GUID: nmn0JyeBmfsooP-FWXVNoLAYLBREAawx
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNDMwMDIyMiBTYWx0ZWRfX8gNP6Rs3vILM
 4vF5Q8X1BZCM/nnu5aeKW4Slo2r1Waz+UCxW0lF20reui7acEAA0qDy99A3RGY8Ycm1tYMyZChm
 PqBQI2RY+9TjbYSKttsrf0ourcro7gZ2bDVJxN8qD13dO/FmaUMHYqeIxfuIQHOnTtJT4kDmaUp
 KiHjV7O11IMdyK1f9m/GVNu98EPnjwPMcs+qKFt0F4GybLCRP05vtKdxHmr7Jj/b7mKZV++1hXj
 iLRH2UOsDM2sb0z3o7uLNLJmGliGrcSNgo6J2QwgXPhrTDnwmpyovpOmZ/q7UP2BdoVJKsJF7EN
 6AKrJBQKBmqPkH6Jprt8WAPVPawS4v90gP/MOGaSyRJIa4x0otnqAnsmyuzkbIMtVgB0prH8Ygz
 fzY4kQFoVUi8jBVRQl2RdzCqgb2lJzvqqQpG/t3nwddcQyZxbJbHbR8my3z6FNvMffnoQB1seBo
 GY+O79qFVBP6GqFtQpg==
X-Authority-Analysis: v=2.4 cv=UcxhjqSN c=1 sm=1 tr=0 ts=69f3ca01 cx=c_pps
 a=cFYjgdjTJScbgFmBucgdfQ==:117 a=ouPCqIW2jiPt+lZRy3xVPw==:17
 a=IkcTkHD0fZMA:10 a=A5OVakUREuEA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=DJpcGTmdVt4CTyJn9g5Z:22
 a=EUspDBNiAAAA:8 a=R8he2_Gm4Sd0DFq6ycoA:9 a=QEXdDO2ut3YA:10
 a=scEy_gLbYbu1JhEsrz4S:22
X-Proofpoint-ORIG-GUID: nmn0JyeBmfsooP-FWXVNoLAYLBREAawx
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-04-30_06,2026-04-30_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 bulkscore=0 clxscore=1011 lowpriorityscore=0 malwarescore=0
 impostorscore=0 adultscore=0 spamscore=0 phishscore=0 priorityscore=1501
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2604200000 definitions=main-2604300222


On Tue, 16 Sep 2025 12:47:21 +0800, pengdonglin wrote:
> Since commit a8bb74acd8efe ("rcu: Consolidate RCU-sched update-side function definitions")
> there is no difference between rcu_read_lock(), rcu_read_lock_bh() and
> rcu_read_lock_sched() in terms of RCU read section and the relevant grace
> period. That means that spin_lock(), which implies rcu_read_lock_sched(),
> also implies rcu_read_lock().
> 
> There is no need no explicitly start a RCU read section if one has already
> been started implicitly by spin_lock().
> 
> [...]

Applied, thanks!

[14/14] wifi: ath9k: Remove redundant rcu_read_lock/unlock() in spin_lock
        commit: c4f518736472c8cfbf1d304e01c631babd2bbf34

Best regards,
-- 
Jeff Johnson <jeff.johnson@oss.qualcomm.com>

