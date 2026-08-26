Received: from mx0a-002e3701.pphosted.com (mx0a-002e3701.pphosted.com [148.163.147.86])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A6B65377A86;
	Wed, 26 Aug 2026 19:12:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=148.163.147.86
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787771541; cv=fail; b=Xoyx8rYNsx92k5fCFl7X7aW9gGIOOsgLx+ZtIKufLtIKgB7DKSzYRGg0a/DqIQl4Ulggq5/q8lfVk6FKjDKbm/TveVqJczYGDwYKzN+NyY44qKWFRJ8NibAbljr8oCGLNgs/xrUalRwJuhXr/JBVDae6yL9DV2PQTQq++i9ROyg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787771541; c=relaxed/simple;
	bh=B0gk4jn4IyLwgv9fCKKt5Q6XjJx6rlJm/FEPja0l28g=;
	h=From:To:CC:Subject:Date:Message-ID:Content-Type:MIME-Version; b=oQGqnkYnPh30YSvqSjPzg2UrxqHdpA53FCE7A4w99ByXM1rzM6E2leWpSJ7cuaJSKRWhawT1Ud+794lUBOsgBKpv93xqavhVXf5Xcw9H+JAtzck4PrT8WnTAWby4d761uulT9Kin7CCqdBoRPdOREAJJvJ1fMHSS3LOtIWQPDG0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=hpe.com; spf=pass smtp.mailfrom=hpe.com; dkim=pass (2048-bit key) header.d=hpe.com header.i=@hpe.com header.b=GNEvAPL2; arc=fail smtp.client-ip=148.163.147.86
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=hpe.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=hpe.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=hpe.com header.i=@hpe.com header.b="GNEvAPL2"
Received: from pps.filterd (m0150242.ppops.net [127.0.0.1])
	by mx0a-002e3701.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 67QIm7NZ3814962;
	Wed, 26 Aug 2026 19:11:50 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=hpe.com; h=cc
	:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=pps0720; bh=B0gk4jn4IyLwgv9fCKKt5Q6X
	jJx6rlJm/FEPja0l28g=; b=GNEvAPL2Tq8QFcvhdDcvLsLXfxr9+pWCJPdpj14A
	sEdXedZ5U7mIgOUHduJXPefRWJ/dXnJHyLwu2jjyqt3pd+gezacRXnnxMIVm6d2M
	Ui/3XSyu1q2YsqaQdHFOOqqHinOKkP55q1S6SztRE949qDwq5y/5aJG6KTUyVZGl
	+qPWYFFvOVKi6donZe3Frfzhq6+OXT2e0kVNUY0BfK1UOsM5896Lz0aUrwd7jngu
	r6NaHk7GxvEEgTWJJOLcr4ZkB59SrQ2QZIKgZAsYtQbIubltssHBHGb31XczBAvA
	qaZkSocLqN5YYEh2aymrL+PYNmsrEdbMwZexR7UBj2HLWw==
Received: from p1lg14881.it.hpe.com (p1lg14881.it.hpe.com [16.230.97.202])
	by mx0a-002e3701.pphosted.com (PPS) with ESMTPS id 4ga2vmtk4k-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Wed, 26 Aug 2026 19:11:49 +0000 (GMT)
Received: from p1wg14925.americas.hpqcorp.net (unknown [10.119.18.114])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by p1lg14881.it.hpe.com (Postfix) with ESMTPS id CE1D5806B1A;
	Wed, 26 Aug 2026 19:11:48 +0000 (UTC)
Received: from p1wg14928.americas.hpqcorp.net (10.119.18.116) by
 p1wg14925.americas.hpqcorp.net (10.119.18.114) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.43; Wed, 26 Aug 2026 07:11:32 -1200
Received: from p1wg14928.americas.hpqcorp.net (10.119.18.116) by
 p1wg14928.americas.hpqcorp.net (10.119.18.116) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.43; Wed, 26 Aug 2026 07:11:31 -1200
Received: from P1WG14918.americas.hpqcorp.net (16.230.19.121) by
 p1wg14928.americas.hpqcorp.net (10.119.18.116) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.43 via Frontend Transport; Wed, 26 Aug 2026 07:11:31 -1200
Received: from CY3PR08CU001.outbound.protection.outlook.com (192.58.206.38) by
 edge.it.hpe.com (16.230.19.121) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.43; Wed, 26 Aug
 2026 19:11:31 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=mko3xifd5xGsl5uH3Z+XLFK4ch8hJHTrVLb+KxQzyG3VGB6oshwvdlh648YHBXaznxdDoCT3wMFX/bGyG3iFj1KuDGEqnBFrNSgcXMKsPQ08z6glDDyxTbwLXbx8pApBHfP7J/Lv2YdmRzGnPk7qYtmkKFJwC2tTZPLmxR2OwRUMvMviE1XeWccpls4PAKyG0HxP8uZu1CP6jxvVP5sOWstZTyLmu5vxYcum9PF3mHUmd4777qu2mGYzUdimyeIVFmu/WYEuuYXrK75zPkl6mrLiBqUQAbdPIB+kR4p0LACVNN1Xka5n8Hqv7JIXsfsMpyCbzWAWCU6pYU1nDXbr1A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=B0gk4jn4IyLwgv9fCKKt5Q6XjJx6rlJm/FEPja0l28g=;
 b=rPpGRI9iz9FnCBE/WZ83HLfpnGcY9u0uqms54T2IDwHXDAJqSBpUCYaiwXiWbia2zGbfrhEaKvwIzs7062LeGVU90JjqhS1izEKC5fZ2SG0t1nl6UOV52dGtl/QN1tY3T94Anv05u6sjnXWN2pLWyV1WJGKXVWKyF2pLJCvWIdlDiHmc/kBTsFdgFKbRR1sNdvZ56dKTZk51HWzVCwCFpN8Ttv2WUUXiLCCLtOtmxfDTN1vq04PoJBmXo0TjTObbnXK09KToxZh9Fh/3wPScm4ChdkSHAZTp6Xt9G2P4p5dgTlVGz9Zt/Xc9QYitFJUvjBs0GbNPeSKrmR5AqZachA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=hpe.com; dmarc=pass action=none header.from=hpe.com; dkim=pass
 header.d=hpe.com; arc=none
Received: from PH7PR84MB1654.NAMPRD84.PROD.OUTLOOK.COM (2603:10b6:510:151::10)
 by PH7PR84MB3552.NAMPRD84.PROD.OUTLOOK.COM (2603:10b6:510:300::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.360.7; Wed, 26 Aug
 2026 19:11:28 +0000
Received: from PH7PR84MB1654.NAMPRD84.PROD.OUTLOOK.COM
 ([fe80::92d8:a8cd:8cda:27c2]) by PH7PR84MB1654.NAMPRD84.PROD.OUTLOOK.COM
 ([fe80::92d8:a8cd:8cda:27c2%5]) with mapi id 15.21.0360.006; Wed, 26 Aug 2026
 19:11:28 +0000
From: "Singh, Jashandeep" <jashandeep.singh@hpe.com>
To: Mimi Zohar <zohar@linux.ibm.com>,
        Roberto Sassu
	<roberto.sassu@huawei.com>,
        Dmitry Kasatkin <dmitry.kasatkin@gmail.com>
CC: Eric Snowberg <eric.snowberg@oracle.com>,
        "linux-integrity@vger.kernel.org" <linux-integrity@vger.kernel.org>,
        "linux-security-module@vger.kernel.org"
	<linux-security-module@vger.kernel.org>,
        "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>,
        Jashandeep Singh <jdsw@juniper.net>
Subject: [PATCH] ima: select the SHA384 PCR bank for the boot aggregate
Thread-Topic: [PATCH] ima: select the SHA384 PCR bank for the boot aggregate
Thread-Index: AQHdNY6y/d21skUpKUejohSnWuMY6A==
Date: Wed, 26 Aug 2026 19:11:28 +0000
Message-ID: <20260826191051.219090-1-jashandeep.singh@hpe.com>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH7PR84MB1654:EE_|PH7PR84MB3552:EE_
x-ms-office365-filtering-correlation-id: 9930b296-f47b-41ea-ed88-08df03a5d4f0
x-ld-processed: 105b2061-b669-4b31-92ac-24d304d195dc,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|23010399003|376014|366016|1800799024|10067099003|18002099003|56012099006|38070700021;
x-microsoft-antispam-message-info: kdnTJNEtIaQTq/+edeTHEke1fNWsYyldRy1XXOneKudpvtxGfsnVLnsicKDPUzS0gxDvQsitTIZ05CxckOapKHMxcFrwbzDoAZgbjR45t9x9kRdlj3MI0kVKXdB2yD6GmlEhtNnaN+57In+BNYMbyImV6WYTvX9p5ODRppNrSt5TrOsQcLzmGqus61dqod5Os5AfzIv2CXyngVvnzZUctHgOo9mYDW/gpxAF2S60nvQfm8ok2TZ4ygUTi7FKg1wfWy23gY9pfla7h1keb7m4YOlPDFYacTSpw8Hq3lh2Zcw79/tqodz3QXYrWG/q5ghjOKATK8BuwCM+wFlOuNgM+hOofJwXlXBDHFJR+e3Zc91hC0bJjMMtorpmKSOP0L6DShUFEhiDulKgCxxAF3JFxaklVSYeHdWZMRSNNqglWXzlgjuMDyhe8+SGBZPb4s/M7IZDqvbKd9saKwUQ6SYWTolg6WntLVsRMdPfDoTvYsQVq3I+SmfkVf4Q44Gt48vYyCv1wp3ZxQoiuT6DyNyrG+LbUrv5etxRaqr20geP/bYsu7QMlIuLltBGlL2hqFKjTK1qhBeMWcPeNw+ETS+L4r5dIREkhX0kue8y0H1llKMxoAa0KgwyqChdKwY4kF1HRehftLUWZO8zHw+TAtAbUXJOLGkMs4kIggC/aulVrvkaN/z1CQ7OV39qBRN4Hf1Iod9HXE5qZmHi8x81Amt59LbieyyhinITY0ToY2WZvPE=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH7PR84MB1654.NAMPRD84.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(23010399003)(376014)(366016)(1800799024)(10067099003)(18002099003)(56012099006)(38070700021);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?NFZieVpiN1d1VmJmNWREdWJvdlBPTkp4SFl6SiszcEo1bzJFdXoySWw1Uno4?=
 =?utf-8?B?dWl3T205S2Q1bGViVVB4dzRkck5NMzBXRUVJTDkzQU9IaE95ZTNGU1lFSXFv?=
 =?utf-8?B?eUQ5UUE1R1BzYlpUaDl3YlMvMHRoRmhyQkQ5Y0VhVmpJM1QzTjA3QUhVRVRG?=
 =?utf-8?B?SzNHQmhVRFJmNXFIMWRiTkpuQ2dQb2JGMlE3TW5IT1E3OU1xNDZNR09zZDNj?=
 =?utf-8?B?bENlWERiNloxbDk0eENza2xiOTlaTGlTbXdrWnlCdVVvVzlRb25yYk9oYy9M?=
 =?utf-8?B?QVV4dVZEU0lTaW9LNzRqOWttOGdnbDFEN2xYUHgyVmdhZ1p0OU9xbXpIY1dj?=
 =?utf-8?B?b0NoRnZXa1FMd0o5VitQenl6MUoyNktRaGZpWTFsQ1hCUnQ0bHpXamF5UVhZ?=
 =?utf-8?B?dE4rQlF3d3RYMXQrME1tOXR4V2p4cVpFdEc0bmsvN0N4SnRvUDYwc1FxbDZK?=
 =?utf-8?B?L0tOMUlONk5LSVJRa1hjNEV2UGJROE4xSy9ZVkpuZ3I0Ym1yR3ZwaWNXUnpH?=
 =?utf-8?B?WUlLUmw2bWV6TmJnYVI2eGdaYVJkelpaWnBWVXl4bWNQZnh2Ukx3RlMzcS8y?=
 =?utf-8?B?NVJxeWFoOWNCSHNPM29CUDBCOHdDelhKcE1TMCtYNTE4MUNEYzhIWTFyNjJM?=
 =?utf-8?B?Z2tLd0tPR040MjRNRnovQzdNeVpRTVZhdW1yVWc0V0NjQVdUVThEZkI2cnlR?=
 =?utf-8?B?b21QRXlaaFZIQ1NidjBhNnpYa1cvV0RMRDd1S3RuMVdCMit1K2pOOXZiYzFp?=
 =?utf-8?B?SnROVDNCcXYvcitqWXpEOGUxOVhOelJZMjNFdHV5Y3BWc0dKUUg2R3cxMFQy?=
 =?utf-8?B?RzlldW5QMzRiU3VzT0NWekZudWVXMEZwOXg5blhCaFVxZ1dWa1NYcnp5azA5?=
 =?utf-8?B?elFPRXNYQjhsYzJGZ3lhVHNZUFJnNzFNUlVEbjU4RTVvL1BZbEVLd0lrckZE?=
 =?utf-8?B?c0swR3RPd3RiYmVINXJTOGFzdWI2OEtkTlErVzhVM1h5ZFFNWkJIdGZmOGI0?=
 =?utf-8?B?dnpweFRjZ3lxR3F6Sys0YjRGN3RXTnFoV2V0dDJzV3l0UHdIZnVPR1FnYXVX?=
 =?utf-8?B?cjFpV0ZqR1J4cGRMSkVKdkxTbDlGVW1qdUN5b3d4eVROaGJ6WFdoRllmZlZa?=
 =?utf-8?B?NEhmZ3RNSjRRb1ZGMkp5TVAwdm9QVWZ0M3dMeEloclp5dHZScXZFZ3lpdTZu?=
 =?utf-8?B?OEpqNU5lVkdkcVZrdnNnY2tUOEdSYmdYU1l4bGxqL1ZLUnZ5OXBNTDh5RnFN?=
 =?utf-8?B?RENmazcwa1c1MkF0S3VRZ2xLS2d1NWx5SnpCRkhPWk5XbzE2VE0zYk5uc1lz?=
 =?utf-8?B?dU5LREViMUxLcThFTElseG5JQ1RvNG9LdmhWQys1L25GVDhvaEdBMXE1azgv?=
 =?utf-8?B?WEZ4eklKd21EcE1JQVRwcVZsSDBmTHdXYXNGdUJON0VNRGJtSjlCV3VUV05D?=
 =?utf-8?B?NWJWSWh2MjZBZFhDSTVqZjJrbnZDWkVxb25nSWVSbFEvSllPTC9EakpXS2Rp?=
 =?utf-8?B?OHFuSndJS1RxVXEwY2hHUDZJZENOTlB2Rytsc213QXM0Q0paSFY1Z1ZqOWlF?=
 =?utf-8?B?U3lqWkZya0c4ci9sdU1BMklYNEl6NlBGVVhlQUpKRWNvZHV1T1ZLWUdsVkZT?=
 =?utf-8?B?ckxqWWF6U0lhK3VJOFdSdCtuTWU4b3BRaEp5QmpjeFJCbkJhVVRkcHFrSDFu?=
 =?utf-8?B?Yk5RcnlYbVI2Nml6U1hNNWQ3WDM3RXU1S3ZzVjBvN3pCMEpFWGNuMTFLb2pQ?=
 =?utf-8?B?U01mTjhkL1RuS2NYVmVMV3A3dHJQY2k3cGN1OWI2VmdOcXRLR3dOOGRYdURh?=
 =?utf-8?B?S1gzMyt4SUR0akx4Z1NBUEg2YmNwY09tenpaeFlXdFVBNURrUXBZRTc4MTdp?=
 =?utf-8?B?UTJyc3lpYTVGOFBzaEJOaWg3MUFXdWlvOEMrVEsySE1zaHFYZHY0U2VEQ1l4?=
 =?utf-8?B?N1hKeFdUUkxoekxYcDJwYWc5SDc4cXc0WG53NG9pc1oxM0wvTGNheElxYkNt?=
 =?utf-8?B?S0dkSTYrd2NCSDhKWWxDNmFXMGN5Sm9udlRFWmFEdnk0SzAxYVFkVHhnYk1F?=
 =?utf-8?B?SnFTN0FPMGNZMkcxMEhzN0d4dHg0YWZGMkxDRkVodHgrZkpHYXg1cmRiczBK?=
 =?utf-8?B?WE52NXdxdWsraFdZTldnS2JMZlZYL2RRRHpHQ0QxTTQ2ZHJsK2QzTzlsNnBj?=
 =?utf-8?B?VWlzNWxLa0ZYaTNYRUQrd0MyTTVrSTdkRkwzTE1XYU05dzVSUElDOW85NWJV?=
 =?utf-8?B?b3pidmpRZUpRQThRc1Mwcjh5NTd3K2Z0Y3JBU3RFWGROaFZBT1pEUEZteldx?=
 =?utf-8?B?VEwrZ0QzbkF5WE9IdnRadUU2bXh6VmUxdjY4bUR6S1g0enE4U0FEUT09?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked: UbciK3CmpVftmtweAD5L2y/7bYPDYKuRTLN2BKHNc9UEPi8KHjh9rbpsLEik4LKm9gjP2YwN8i2b1faXMzR80t9yEpC7+jo9ghuBFy6odudZqYEu25Mg1SctJvtag0NPcB7S25dWemfQTSFkKy7dNA/EL4Z4CqiTxSXJu7xP/SL5KP/AByz88URTOXfK5hD90AQufu1V4K9ZBLWlbUEpKkYSoKjwtByJyrJ9QJDlTYxknIsrMBMaykC1esdfY1ZmWYq6MLlU9NenSsfvTMMbfs3V8OwNZrhkvBjYgyoHXtmjysK5Q7GJpjBsfWkD7Fd9EoZ27szw/Tfwezrm8NCORQ==
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH7PR84MB1654.NAMPRD84.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-Network-Message-Id: 9930b296-f47b-41ea-ed88-08df03a5d4f0
X-MS-Exchange-CrossTenant-originalarrivaltime: 26 Aug 2026 19:11:28.6857
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 105b2061-b669-4b31-92ac-24d304d195dc
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: iPFvms+DN5shysLhmjYh3teJ3kXsiOXV6RV3nWVpSpM93cT3kNo6VAoA8dH8UgHUCiYOXHYrt1M8FjpuihktRGfl85W8fuUibp8nx4Gr5o8=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR84MB3552
X-OriginatorOrg: hpe.com
X-Proofpoint-Reinject: loops=2 maxloops=12
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODI2MDE2MSBTYWx0ZWRfXxqiNqxxmAK0f
 WVVE32gypZLVMpoRSHNgJ5Ee8/+90FqYW1nLGY4wbg/VtCFtbESmKi4IhWtoTNE13A1fGnaHLfs
 5N/7OasJ/tNieD/Iuw3t5zlgrHeAcIYCmCIDFUSrk6vd571FCtaLNIv4zPyoPU5h9kwO/mkCAuj
 Z/tVLAuMSTmQp/Jqnu8nAcF7tiysX4fgQdB/22CkeLrPEViR5YaLLgD8IrVGYWOxXFPysqoao0z
 KEgL+rX6tfCqKYPIeaXGEVwpZueFIgmo6Qsop8AlKlJqgu0VzWUcgKb/Dq4zUSxzvIzE5+DA2k2
 bexvZAJsrSAOgnbggEVk2ExOCEKw+5oBb/vkn+jOizUGt3fEJM/RV5HoGmdZ8WO5lnleGXXQhYq
 JXCx2xjkScxT3kUls5BgqBrSsmI+hlz3vLwuLhZpcniIqC615rT4gFiHmESyOHK4qzn/e1aH9jQ
 +18prMaXFvBBcmv1YXg==
X-Proofpoint-Spam-Info: AW1haW4tMjYwODI2MDE2MSBTYWx0ZWRfXxIzVecdx510c
 fhow7vdtlViRsrnZdJHN9dIxvKnBGw1nM7vi9vg2zojuu6anDbOCvEgPFmidcrQCVjwGSP3jwDE
 yuIwWPYbDHpExF/JF3uVhyR6Q/97CNo=
X-Authority-Analysis: v=2.4 cv=WZo8rUhX c=1 sm=1 tr=0 ts=6a8f3a75 cx=c_pps
 a=FAnPgvRYq/vnBSvlTDCQOQ==:117 a=FAnPgvRYq/vnBSvlTDCQOQ==:17
 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19
 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10 a=Sv0fKeRqtYgA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=gQcMVamqm3wCPoSYhaRC:22 a=J0OTuHAx6l5K1fCpvPfz:22
 a=OUXY8nFuAAAA:8 a=ZWG7SqJv0os1ATTUOcQA:9 a=QEXdDO2ut3YA:10
 a=cAcMbU7R10T-QSRYIcO_:22
X-Proofpoint-GUID: DUd1nHj61hI2rmodMbANI5jpZsS_ZE--
X-Proofpoint-ORIG-GUID: Dkp7Ad7AOPNDlNxJFdf-o6lD3azYMBCF
X-HPE-SCL: -1
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-26_05,2026-08-26_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 lowpriorityscore=0 adultscore=0 spamscore=0 priorityscore=1501
 impostorscore=0 malwarescore=0 suspectscore=0 bulkscore=0 clxscore=1011
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2608260161

RnJvbTogSmFzaGFuZGVlcCBTaW5naCA8amRzd0BqdW5pcGVyLm5ldD4KCmltYV9jYWxjX2Jvb3Rf
YWdncmVnYXRlKCkgc2VsZWN0cyBhIFRQTSBQQ1IgYmFuayBtYXRjaGluZyB0aGUKY29uZmlndXJl
ZCBJTUEgaGFzaCBhbGdvcml0aG0sIG90aGVyd2lzZSBmYWxsaW5nIGJhY2sgdG8gdGhlIFNIQTI1
NgpiYW5rIG9yIHRoZSBTSEExIGJhbmsuCgpBIFRQTSAyLjAgY2FuIGJlIHByb3Zpc2lvbmVkIHdp
dGggb25seSB0aGUgU0hBMzg0IGJhbmsgZW5hYmxlZCwgd2l0aCBubwpTSEEyNTYgb3IgU0hBMSBi
YW5rLiBOb25lIG9mIHRoZSBhYm92ZSB0aGVuIG1hdGNoZWQsIHNlbGVjdGlvbiBmYWlsZWQKd2l0
aAoKICAgIGltYTogTm8gc3VpdGFibGUgVFBNIGFsZ29yaXRobSBmb3IgYm9vdCBhZ2dyZWdhdGUK
CmFuZCB0aGUgYm9vdCBhZ2dyZWdhdGUgZGlnZXN0IHdhcyBsZWZ0IGFzIHplcm9zLCBhcyBmb3Ig
VFBNIGJ5cGFzcywKbWFraW5nIHJlbW90ZSBhdHRlc3RhdGlvbiBpbXBvc3NpYmxlLgoKQWNjZXB0
IHRoZSBTSEEzODQgYmFuayBhcyBhIGZhbGxiYWNrLiBUaGUgY29uZmlndXJlZCBJTUEgaGFzaCBh
bGdvcml0aG0KaXMgc3RpbGwgbWF0Y2hlZCBmaXJzdC4KClNpZ25lZC1vZmYtYnk6IEphc2hhbmRl
ZXAgU2luZ2ggPGpkc3dAanVuaXBlci5uZXQ+Ci0tLQogc2VjdXJpdHkvaW50ZWdyaXR5L2ltYS9p
bWFfY3J5cHRvLmMgfCAzICsrLQogMSBmaWxlIGNoYW5nZWQsIDIgaW5zZXJ0aW9ucygrKSwgMSBk
ZWxldGlvbigtKQoKZGlmZiAtLWdpdCBhL3NlY3VyaXR5L2ludGVncml0eS9pbWEvaW1hX2NyeXB0
by5jIGIvc2VjdXJpdHkvaW50ZWdyaXR5L2ltYS9pbWFfY3J5cHRvLmMKaW5kZXggMGQ3MmI0ODI0
OWVlLi5jN2E2MGI0Mzg5NTUgMTAwNjQ0Ci0tLSBhL3NlY3VyaXR5L2ludGVncml0eS9pbWEvaW1h
X2NyeXB0by5jCisrKyBiL3NlY3VyaXR5L2ludGVncml0eS9pbWEvaW1hX2NyeXB0by5jCkBAIC00
OTEsNyArNDkxLDggQEAgaW50IGltYV9jYWxjX2Jvb3RfYWdncmVnYXRlKHN0cnVjdCBpbWFfZGln
ZXN0X2RhdGEgKmhhc2gpCiAJCQlicmVhazsKIAkJfQogCi0JCWlmIChjcnlwdG9faWQgPT0gSEFT
SF9BTEdPX1NIQTI1NikKKwkJaWYgKGNyeXB0b19pZCA9PSBIQVNIX0FMR09fU0hBMjU2IHx8CisJ
CSAgICBjcnlwdG9faWQgPT0gSEFTSF9BTEdPX1NIQTM4NCkKIAkJCWJhbmtfaWR4ID0gaTsKIAog
CQlpZiAoYmFua19pZHggPT0gLTEgJiYgY3J5cHRvX2lkID09IEhBU0hfQUxHT19TSEExKQotLSAK
Mi4zNC4xCgo=
