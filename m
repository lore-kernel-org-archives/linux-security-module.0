Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 958C01B4223;
	Wed, 21 Jan 2026 02:14:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.165.32
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768961688; cv=none; b=FnT+RLtqiOdSdKz0xGVHwZcTHgXCZWoC1myTEkQNtBuciZipqZ0u/GVMIe2o3bH+LVMoWsv6XVuGE5/jNcIROSWhFiOA0x7Cb2ikZfA82+0G4XjGE5ky7JRGxSUucZGyEwyGdnjyWBlMYoOIodu1W0BMrkDpqfv3nfHD4U6PPrQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768961688; c=relaxed/simple;
	bh=+VU/5+GtMQCmxJITGpUxqmCSpN2iCuJboXxFd2d+4L0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=jK5pxA/raQMsfSEE5M0ewmzdZN1LeEVokZFX6pImryD4KMLPG65CElUlVNUkTjfFWxqA8V3dtPXleVtQCsn8zMnpmd/FTX0bnGoULjgEnFci4cEXUdM0xizTssU+klicHjZ9vNOQOpoZYMkF5szlm/NWnFcs3IQQgfj25h4BoFA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=GzbraiEK; arc=none smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="GzbraiEK"
Received: from pps.filterd (m0246617.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 60KIck473032110;
	Wed, 21 Jan 2026 02:14:41 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=corp-2025-04-25; bh=Sz3mo
	lskkerDj7ax+7g16iiI7PZbmekCL4E8nCy4Lic=; b=GzbraiEKY/skrDIRHzXtl
	EGL86+g0pB9Kndj1beXb1htCTGIO6ERpXAy/qbBSzOcnBPKM1srG5k6IzRFxqDhs
	rznFaMcmmnz2DBLtMdfeixVIkddmt8vTKacDpy+YBv4VIZVR3ck478hVPxynDcdF
	D4KmcS96igW9Yqa4nF7MEpsyNbXHoEGPxuoJ2HNDyyZUy+k8Kp83Tl1HH24nTOtD
	aUjUHNGwsFbTZPpDS8g4caT3zOpE1frNJomX7baQNj27ipEwG0fGjRtRezfHAPwz
	v9geijaeR/k9T0IpDroZOc/7UuB4DAe4AWWhTfHq8ieeE5ZzoyndoHHQRwUFqzAe
	w==
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta01.appoci.oracle.com [138.1.114.2])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 4br2ypvuas-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 21 Jan 2026 02:14:40 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 60L0KI52015492;
	Wed, 21 Jan 2026 02:14:40 GMT
Received: from pps.reinject (localhost [127.0.0.1])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 4br0vajpvt-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 21 Jan 2026 02:14:40 +0000
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 60L2EdQb032867;
	Wed, 21 Jan 2026 02:14:39 GMT
Received: from ca-dev112.us.oracle.com (ca-dev112.us.oracle.com [10.129.136.47])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTP id 4br0vajpvk-1;
	Wed, 21 Jan 2026 02:14:39 +0000
From: Samasth Norway Ananda <samasth.norway.ananda@oracle.com>
To: samasth.norway.ananda@oracle.com
Cc: gnoack@google.com, linux-kernel@vger.kernel.org,
        linux-security-module@vger.kernel.org, mic@digikod.net
Subject: [PATCH v2] [Reminder] Landlock documentation improvements
Date: Tue, 20 Jan 2026 18:14:38 -0800
Message-ID: <20260121021438.1939661-1-samasth.norway.ananda@oracle.com>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20260103002722.1465371-1-samasth.norway.ananda@oracle.com>
References: <20260103002722.1465371-1-samasth.norway.ananda@oracle.com>
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.20,FMLib:17.12.100.49
 definitions=2026-01-21_01,2026-01-20_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0 mlxscore=0 adultscore=0
 phishscore=0 suspectscore=0 spamscore=0 mlxlogscore=850 bulkscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2601150000
 definitions=main-2601210017
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMTIxMDAxNyBTYWx0ZWRfXyWZ1NqNILjT3
 8h5VHWApr1rnX7M8Ry7Ky0ctRWCN2wPFSrsetdIMYYVqksXHKGC5agxq6j69rFSpiYAKeRVuXJd
 ylJJUSw8MO5agh8K4n/DgD0dmmlg9lGr3E9X7TOSF+arOUc5+dAG15sMwNdFCsN48g+MggdrPtP
 FKgcW+EhNLxw1D7aj//BbXEEqahxw1vIRWru9v6ILoAxN05U5eqDUcazklRQuLyX7HBH/dLH4S2
 A17vzkF8DkNiRnQMWxR7Co1FsMkCt1krgvnizNJE3whNIPDdzsJuv6drnWpQQ/tpJoXmOa0FBdj
 1d3sbdjS8SWR6E2LFbwVyoR6kUXKuotezaKBl/Tc4A1gZmYrOG8UZ0nXSWt11ePb7nAJc3gGYbV
 djpzsBUpFO8fuSxiUM5yAsUvJyWuaM0w55Pg+ZxmuC91mbebSSNUtanDm5JsV6qOlOetXYUVZwy
 cSz8q1RU0KXJsmUSjpg==
X-Authority-Analysis: v=2.4 cv=de6NHHXe c=1 sm=1 tr=0 ts=69703690 cx=c_pps
 a=XiAAW1AwiKB2Y8Wsi+sD2Q==:117 a=XiAAW1AwiKB2Y8Wsi+sD2Q==:17
 a=vUbySO9Y5rIA:10 a=VkNPw1HP01LnGYTKEx00:22 a=VwQbUJbxAAAA:8 a=yPCof4ZbAAAA:8
 a=QT1oPoSZdec7cShRik8A:9 a=ZXulRonScM0A:10
X-Proofpoint-ORIG-GUID: anMKzacQBoyCsCQJ-0GddTCx-oRTjB5e
X-Proofpoint-GUID: anMKzacQBoyCsCQJ-0GddTCx-oRTjB5e

Hi Mickael/Gunther,

Just a friendly ping on the landlock documentation v2 patchset. I haven't heard back yet, and I wanted to check if you had the chance to review it.
If there are any issues or further changes required, please let me know.

("landlock: Documentation improvements")
https://lore.kernel.org/linux-security-module/20260103002722.1465371-1-samasth.norway.ananda@oracle.com/

Thanks again for your time and feedback!

Best regards,  
Samasth.
