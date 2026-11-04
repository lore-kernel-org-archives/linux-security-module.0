Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=148.163.143.35
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1793761977;
	b=GjuMCnH2h37hveIDp+f26IOxhew5695lF0SHovDXpZbgnG5HJmrGifhSBiqlkJ5ghwUa
	 CJHR/r1YSh/0sAQIJaZXtWRzZ/PDkSzJLnA26l+6HBkSipmWVtAPE0wGw6XaqTm5sXoMa
	 m4e05gR8sr1gWv72+KlFqBwCf7W4tu2JSq+upUoMrHsSWdsqyPw7g2q02AtZK0q7B4Fn+
	 hPk/VwhYubv/D1xfxTBQQfIac52xC4CWovLGaYLNQIFqVjb3I5YTnG3WuV6gxBkIWhYkf
	 wRANxf5Q9A3wDV+v+CMoXCfnmjY/Zt//vydNdKgBtmvdmWjuiUngbagJFK8QjUNt3lw==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793761977;
	h=DMARC-Filter:Received:DKIM-Signature:Received:DKIM-Signature:
	 Received:Received:X-MS-Exchange-Authentication-Results:Received-SPF:
	 Received:Received:Received:Received:Received:From:To:CC:Subject:Date:
	 Message-ID:X-Mailer:MIME-Version:Content-Transfer-Encoding:
	 Content-Type:X-EOPAttributedMessage:X-MS-PublicTrafficType:
	 X-MS-TrafficTypeDiagnostic:X-MS-Office365-Filtering-Correlation-Id:
	 X-MS-Exchange-SenderADCheck:X-MS-Exchange-AntiSpam-Relay:
	 X-Microsoft-Antispam:X-Microsoft-Antispam-Message-Info:
	 X-Forefront-Antispam-Report:
	 X-MS-Exchange-AntiSpam-MessageData-ChunkCount:
	 X-MS-Exchange-AntiSpam-MessageData-0:X-Exchange-RoutingPolicyChecked:
	 X-OriginatorOrg:X-MS-Exchange-CrossTenant-OriginalArrivalTime:
	 X-MS-Exchange-CrossTenant-Network-Message-Id:
	 X-MS-Exchange-CrossTenant-Id:
	 X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp:
	 X-MS-Exchange-CrossTenant-AuthSource:X-MS-Exchange-CrossTenant-AuthAs:
	 X-MS-Exchange-CrossTenant-FromEntityHeader:
	 X-MS-Exchange-Transport-CrossTenantHeadersStamped:
	 X-Proofpoint-Spam-Details-Enc:X-Proofpoint-GUID:X-Authority-Analysis:
	 X-Proofpoint-ORIG-GUID:X-Proofpoint-Spam-Info:
	 X-Proofpoint-Virus-Version:X-Proofpoint-Spam-Reason:
	 X-Proofpoint-Spam-Details;
	bh=enRHvTbpOV/hmpa80WQFZ6Gm1ObDcCWYHC26R17qh2s=;
	b=Z24p/Wt05wRjlIywCd0xRU8pwjpRZiBAMch6L2rAtiLD76A5OFhyTyXSMZPbZoLfkQm6
	 HS/7aY74BOw6xK1W97EezSoJsapS7LNCg7kd90DCo+YbTy6AggpbCLlwV19qyYSMB2tSV
	 ohFpDOZ3D3SuiAWDZp3erVCDmi+HAa3G5TY+F5H8oOE/OtcUIy60bGxhlpQ13+K9ALJOH
	 3phSc9nZ0Tth8lRVQiF5mrfJ2TOzyrlZL3ygmwonr0Wes2HV15kTIDLxKwioGN39TwdqR
	 7L7S6QikDitDgfb4T6TxBhAsWFVN8mo+WiXhQ3MFkxEub9oaaZgFBsGqZQOLTzjFEfQ==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=juniper.net;
	spf=fail smtp.mailfrom=junipernetworks.onmicrosoft.com;
	dkim=pass header.d=juniper.net header.i=@juniper.net header.a=rsa-sha256 header.s=jnprhpepp0429 header.b="iJoqE/A5";
	dkim=pass header.d=juniper.net header.i=@juniper.net header.a=rsa-sha256 header.s=selector2 header.b=mx9LplDu;
	arc=pass header.oldest-pass=0 smtp.remote-ip=148.163.143.35
Received: from mx0b-002e3701.pphosted.com (mx0b-002e3701.pphosted.com [148.163.143.35])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C6866606A32F;
	Wed,  4 Nov 2026 03:12:55 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org C6866606A32F
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=juniper.net
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=junipernetworks.onmicrosoft.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=juniper.net header.i=@juniper.net header.a=rsa-sha256 header.s=jnprhpepp0429 header.b=iJoqE/A5;
	dkim=pass (2048-bit key, unprotected) header.d=juniper.net header.i=@juniper.net header.a=rsa-sha256 header.s=selector2 header.b=mx9LplDu
Received: from pps.filterd (m0134424.ppops.net [127.0.0.1])
	by mx0b-002e3701.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6A42Dx4k3350246;
	Wed, 4 Nov 2026 03:12:19 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=juniper.net; h=
	cc:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=jnprhpepp0429; bh=enRHvTbpOV/hmpa80W
	QFZ6Gm1ObDcCWYHC26R17qh2s=; b=iJoqE/A5EXYU6F+7OYXt1S3U9olHdQHOQM
	n9fKzvwybCTZ7pAH25Euz2uoTiUtrU6+wzQLOBzLcP8z8Lh2qZ0yQqImkcBdAoUK
	UmKrX7t+zh+nB1PXUXXKBvekOYCz15LUS0ECYGL6JT1pI0cIirjbQIUgD3nPedDA
	a/xy2Ahbv0H43p9e9lICXuIlvwmLlOkd31SbQBV4aQ3S3WlaD7Yytv11Bs8fKnGm
	TrxMPuARIsxj268YVKRgUDZ8//i3t97/qEkddZi+uthuc1dzpK51GILirLGzc/lm
	KRrhTWmfvl8QQsAUW52JkFLlc8HHmqr5NcvNUy+PxbRMFDRlmC1w==
Received: from byapr05cu005.outbound.protection.outlook.com (mail-westusazon11010069.outbound.protection.outlook.com [52.101.85.69])
	by mx0b-002e3701.pphosted.com (PPS) with ESMTPS id 4hqur8rjyw-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Wed, 04 Nov 2026 03:12:19 +0000 (GMT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ocOQA7Ln0egYW/o/e4Dkw1bdhhNVVrve4tD9FJcZgTRfQfgi4AZQiZs4WfxpSp3GGOEZ7CEGL3D+MpHLSZOCPAtSGwbfL45Ss2y4lieQG2dDGtOob7ZF23CRCYil/qwCBNBqGsmyYcA493jutLYe0w5xG95GUYdByFhPszsxibobt4boSsIhttBQTymDYtCRVEzP97X7oMzfvd80HEvPtytMgFi1Us5WOlv45/BsG3lvBlhKsdLdPewuo3QD4GCzlEyBp5e0TOK/1HoLaZHklesH4paY54GEFIigl3s9Q2szDSsJRS8rg1rKLYfG3VLtia4lZkepDSunAXK1lTK6Iw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001; h=From:Date:Subject:Message-ID:MIME-Version;
 bh=enRHvTbpOV/hmpa80WQFZ6Gm1ObDcCWYHC26R17qh2s=;
 b=MRrB7jN5po2yDEHrrfZ6CfQ8NGF5RAPl2i4W+RjYJUQh5uray3i/EotIsrP8/NGGcG0hcEql3ls2uQQMuImMQPeU6WhRC5g2HYDewjV7Gz8n3sMb6uCgH/CYKaCvpzxSRFTlp3KPxvAAF/I/Ailgx7ZULfKduYvtEhVbF2vrtr37EpPRONLaYME06Cm5nT1PTA4I3o/tEQL/2jYccuxobuP2Szy+tnWRRChK6mzbX4ZKc3zkd1qMpGU3/e9HWUoOrBjOcrB6UOx00ouKiwwOXqqTcKKsph1/npQIf7XYRefwu6ANxYdzWfeniUks8qlPnSAKM/+z4ZaQ8yiH3/Clcg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none (sender ip is
 66.129.239.19) smtp.rcpttodomain=gmail.com
 smtp.mailfrom=07b6124a9d63.juniper.net; dmarc=fail (p=reject sp=reject
 pct=100) action=oreject header.from=juniper.net; dkim=none (message not
 signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=juniper.net;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=enRHvTbpOV/hmpa80WQFZ6Gm1ObDcCWYHC26R17qh2s=;
 b=mx9LplDuLw2a6i/jF8dmx7SnnsCREUQLwYhCJh6l53df5N5U+pGOEV92uGzX+Ogvi5DClCykA6JrzLC4R/EFRvUFVQIefavFFwTyFNMVb24hrQemHsVnUyWBGui/deGfFBEYViRcsY/T00yBCubewyjgkGMaRDRRisc+lz9jdiKnUGvjmKYHObHS0uTb6zz5vDY3U1Vwni80ogE6cjxKMaFZ5PcuEAg3qH159Lf8Pd2mtVXiW5hzWCqnOClsVb2+QAGCctiHPCdImdJzkUAm9b36c2T+DWZRDhoz+SCz4xJT4rDOwhkY6UVWho8J/fvWa6moVow2ysPfCjGH8CDEHw==
Received: from MW4PR03CA0331.namprd03.prod.outlook.com (2603:10b6:303:dc::6)
 by DS4PR05MB869168.namprd05.prod.outlook.com (2603:10b6:8:50b::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.592.8; Wed, 4 Nov 2026
 03:12:16 +0000
Received: from MWH0EPF000C618B.namprd02.prod.outlook.com
 (2603:10b6:303:dc:cafe::59) by MW4PR03CA0331.outlook.office365.com
 (2603:10b6:303:dc::6) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.592.10 via Frontend Transport; Wed, 4
 Nov 2026 03:12:15 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=none (sender IP
 is 66.129.239.19) smtp.mailfrom=07b6124a9d63.juniper.net; dkim=none (message
 not signed) header.d=none;dmarc=fail action=oreject header.from=juniper.net;
Received-SPF: None (protection.outlook.com: 07b6124a9d63.juniper.net does not
 designate permitted sender hosts)
Received: from juniper.net (66.129.239.19) by
 MWH0EPF000C618B.mail.protection.outlook.com (10.167.249.123) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.592.5 via Frontend Transport; Wed, 4 Nov 2026 03:12:15 +0000
Received: from p-exchbe-eqx-03.jnpr.net (10.104.9.86) by
 p-exchfe-eqx-04.jnpr.net (10.104.9.52) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Tue, 3 Nov 2026 19:12:15 -0800
Received: from p-exchbe-eqx-04.jnpr.net (10.104.9.87) by
 p-exchbe-eqx-03.jnpr.net (10.104.9.86) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Tue, 3 Nov 2026 19:12:14 -0800
Received: from 07b6124a9d63.juniper.net (10.104.20.6) by
 p-exchbe-eqx-04.jnpr.net (10.104.9.87) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37 via Frontend Transport; Tue, 3 Nov 2026 19:12:14 -0800
Received: by 07b6124a9d63.juniper.net (Postfix, from userid 14867)
	id 8C8EA1726B40; Tue,  3 Nov 2026 19:12:14 -0800 (PST)
From: Prashant Singh <singhpra@juniper.net>
To: <bpf@vger.kernel.org>
CC: Prashant Singh <singhpra@juniper.net>,
        Alexei Starovoitov
	<ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        John Fastabend
	<john.fastabend@gmail.com>,
        <linux-security-module@vger.kernel.org>
Subject: [RFC] Curated eBPF/LSM mitigations for high-impact fixed CVEs
Date: Tue, 3 Nov 2026 19:12:10 -0800
Message-ID: <20261104031210.118572-1-singhpra@juniper.net>
X-Mailer: git-send-email 2.34.1
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Post: <mailto:linux-security-module@vger.kernel.org>
List-Help: <mailto:linux-security-module+help@vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-security-module+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MWH0EPF000C618B:EE_|DS4PR05MB869168:EE_
X-MS-Office365-Filtering-Correlation-Id: 20df9d1e-4255-4eaf-f4bc-08df3a216d88
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|1800799024|35950700016|82310400026|56012099006|11063799006|261028144727099003|261009223027099003|261022105027099003|261026140227099003|10067099003|18002099003|13003099007;
X-Microsoft-Antispam-Message-Info:
	eu6jtWYJo4TT2LfIZdudwrmSf2pCtvXsoz0jBoLq0kVjj7WWiFEk+WjiS4Jvx3hy4BjEZDBNA/9RiHt3RsKUgFPNV4nxOvegl4EeA5ueSESMmVYbO8bxdJbQ0hmFbOEz6ow7IhFEz6VXH/qEJ19bGqs1axqYFX8wlpyCpug6K55nWyHoLcR1LRSrrp7ajSA/Go92nZTzDVdEXq/G4mCP73w0s/pzO98pAQVRfjXpEXYOzpz90sradze8gIUgVCmqVsWkOksxzgg7PyB/Q2dBEbvT3XU9nygD+isSbv4MvREzT/eiiBogfc+4XRs7/fSKaeCxNM/StSXl8sgLkVg5k+CpG/dfWRtSrOJcuuIkSBDMeI62bg2vAfyaR55MXqLwYvhjBDm93aXH5F7WZ9r31RRSKFebwUNudYqUwCvIuOvRqvywPniESN1zzX9elbRRY16HavPEgb2in6hyr0cs24xWePxgiRoopXORvxxr6SjLkD8erHhYZsvQznz6T56t5ph1y7VG3srPBywGu/YUX6J1PI7R24kYIsyf0SbxtA3McXRgX1fWG2t4ar1u9JJpHQSl/T3MnRjq+ohM7UGrvjjd3/nVrK1UvEcDsfvouwcqzWOlUP8lbOl6JaK+gN7HFV+l+0/1mXnG6omDCjYrESbqRuTMwC2Z2ut0sSlE6x10lx7Ew2xSyZjQyOGLxyrPKo96scvSMsUfY+mHPmRRQg==
X-Forefront-Antispam-Report:
	CIP:66.129.239.19;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:juniper.net;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(376014)(1800799024)(35950700016)(82310400026)(56012099006)(11063799006)(261028144727099003)(261009223027099003)(261022105027099003)(261026140227099003)(10067099003)(18002099003)(13003099007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	MGdCH1wIwQRJwyEdaKH25n+NjMJ+2RNQa8BlngIsEWli0HnzWBxwKcQm22AFadWDpMNWLrrc6u2Fp+0UtKd0dTmZoH+7u6ZqdLstia9OTDw2Pgv27ohQnXOS9VxLoNNw8PBo+N9/Fqv3Au9zw7GY9UTJW6B365cqVfOOkBLeVMfgL3N3prnCZXrvObtfNQQfKu8+K3ow7YovdDiuvBv1QViEXeMjWiTofEFD/4mH9N+wQmmejfjDVRFAuxFXcjinZyAMLMc3bCz0EbGf400+4FkcYqjHnQnR8V24rtAu2uU+YudO6xJUagAuK7gOSTAXXbvXfjWBXaE3XxGtWQZHHf76GpGtLcCZw1IzEALK1TQzNYyFO1l7fTnYbgZsxe04hrL2HsZhNe45qzTOlOSZ9nQ4202pk/KZHw+tmTh1NXpShG+yuElNZEtzS3YrMh80
X-Exchange-RoutingPolicyChecked:
	BZOMmu/X4fe8C50B/6E60w1kJ//MLZ2fOFhG53ka0sPgwMAazyM0QPTcuCXTQhsY2/hGjn/TZWNDpK0QiNRVrH5U4KnZXza2/d1lcggwWmlsLHgRm6YpNCuJdsELVqE3mMDtqtKSuHb5dmcU/wlk822d/hV+NTgRUZEkcGMMPUeg/Noz4Iul/l+tKVhUhcK8W3ADQORN43n0+VnhsrdugevVryvF1hwtx3wGQtw2RjbfZKLhpCQ+J0gum1N9CeLrq2jTRY5nJwdULFrRenuwS93PZrvK6HIWgtVgta8VX0E/A2xgP+QUCdXEdr3ysTLdGxk1N/Q858ruxZS4bcPSPQ==
X-OriginatorOrg: juniper.net
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Nov 2026 03:12:15.5342
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 20df9d1e-4255-4eaf-f4bc-08df3a216d88
X-MS-Exchange-CrossTenant-Id: bea78b3c-4cdb-4130-854a-1d193232e5f4
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=bea78b3c-4cdb-4130-854a-1d193232e5f4;Ip=[66.129.239.19];Helo=[juniper.net]
X-MS-Exchange-CrossTenant-AuthSource:
	MWH0EPF000C618B.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS4PR05MB869168
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTA0MDAxMSBTYWx0ZWRfX2ge+KbwEOAcA
 Vv8hfuDi7AGVraB0VYkF8mvdFBbroooUXbv5s+qR1y4fqq/uCqlk0HQMrd+ZMrWSL57HXVdwXtO
 XEy0IQizAD3w5mQalaPyr7SBYhkixz6B5/Ku16qWbNaZZMwA9Z2g3nlBeZFYzmG9fVKPz+Ipz6I
 95UxgqhoESEgDsaP/IoMk8q775vNjKmzBQ8HO81I8nv4MEjmCwoh6G1F0RGio0Y70q0aVqDJNi7
 D1StdNw9llAx9wf7DroiTuy7dXH/5qDVj0uOHGvaVfdKehUokWApb11ujTpx5ns3xeSng0SaKw1
 iQ8/JvbxJ/jxhK/hvj9Vc7Ms/ZFKCFGeffKtor5taMpO5rM4IzBW6T5lRjvy2catGzUStRwIp4K
 j92IAZyZjAMFN/PlP5+EOqczU2cHYG7bECCusu/0N4+vFm6qA6bMSLLquUTrFUvXVLVkh+0wPGE
 Hqe/GerHsoPMUyxkoSQ==
X-Proofpoint-GUID: V_CHm7aPIxOBkCy-uwEJkgkfrBuMM1IS
X-Authority-Analysis: v=2.4 cv=bff+w+PB c=1 sm=1 tr=0 ts=6aeaa293 cx=c_pps
 a=uhkaN0mRh0u8fl/99TXUBg==:117 a=SKdRtqzh2DBFgDMvUaaGnA==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=zJRp6_cAMcgA:10 a=s63m1ICgrNkA:10
 a=f7IdgyKtn90A:10 a=rhJc5-LppCAA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=gQcMVamqm3wCPoSYhaRC:22 a=3haJ9R1Aw3gUfsUHDaCR:22 a=NEAV23lmAAAA:8
 a=AcK-SXk5fwNc3BhgcqgA:9
X-Proofpoint-ORIG-GUID: V_CHm7aPIxOBkCy-uwEJkgkfrBuMM1IS
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTA0MDAxMSBTYWx0ZWRfX6wmziJt3K9Q3
 wzHwDXbXqNho3ztuxDk2l7RBOW0jQZF7gJXJko5PenRCLol8NNQs48+Kulpo+Q3shnvA8EYNeRz
 Q6XfYN08HSXiUAxDa1TNUV+yNQo4G0Y=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-04_01,2026-11-03_04,2025-10-01_01
X-Proofpoint-Spam-Reason: orgsafe
X-Proofpoint-Spam-Details: rule=outbound_safe policy=outbound score=0
 malwarescore=0 phishscore=0 impostorscore=0 bulkscore=0 lowpriorityscore=0
 adultscore=0 priorityscore=1501 clxscore=1011 spamscore=0 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=orgsafe scancount=1 engine=8.22.0-2610300000
 definitions=main-2611040011

Hi all,

Floating below idea to gauge interest:

A small, curated catalogue of tested eBPF/LSM mitigations for a handful
of high-impact, already-fixed, blockable CVEs - each entry with details
on whether it is full-block or partial. A bridge for fleets that can't
reboot on demand and where livepatch isn't available - one eBPF/LSM
object covers many kernel versions without a per-build patch.

Being public, each entry is tested against far more kernels and
workloads than any single team could cover, so bypasses and regressions
are caught and fixed quickly.

A couple of additional thoughts:
 - Ownership: a named owner per entry, so there's someone accountable.
 - Coverage and effectiveness: the CVE reporter / fix author is best
   placed to say whether a proposed mitigation actually covers the
   vulnerable path and what bypasses remain.

Prior art: Tetragon ran into the same questions and is discussing where
such policies should live and who owns them:

  https://github.com/cilium/tetragon/issues/5172

Questions for the list:
 1. Is there interest, or is this better left to distros and projects
    like Tetragon?
 2. Where should it live and who maintains it?

Regards,
Prashant Singh
