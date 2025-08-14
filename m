Received: from TYPPR03CU001.outbound.protection.outlook.com (mail-japaneastazon11012038.outbound.protection.outlook.com [52.101.126.38])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 157ED321422;
	Thu, 14 Aug 2025 14:27:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.126.38
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755181629; cv=fail; b=h3SKojd9celc3qnyX0wPQ6tqrkan0tKE0bdCZJAuXiGMzemLE88cKEHAqJij7OU0nUriBa7NYU7w6CdtSvm0tJivYDLUoqCyJG4mPdyoi8egGNQJniUgqAfw4+vyeAyhZuGWRdNuZ2U0vKeYnG0qDOm6GQ3tU6uaH94oAub35wA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755181629; c=relaxed/simple;
	bh=Ijw6XuYSFn0DPfxFavkxWo7rudFLO68RvTRJ+qzQALE=;
	h=From:To:Cc:Subject:Date:Message-Id:Content-Type:MIME-Version; b=KJgIqRzCoOkJyJ3x3SEosq9ciDBmhWHfNoBX1dztr1XXbMFj2JLok1leq+XX4leM73a8YNVrxsdhYAyHRn0cwjlJciKvi8z1pN25uqMt/vbqa5v1vGkb0bPZ3+voWNkIZtuo6C+EPRFZnaQ6AG4OKtcF7Q2kJmbNVACQq+3Teps=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=vivo.com; spf=pass smtp.mailfrom=vivo.com; dkim=pass (2048-bit key) header.d=vivo.com header.i=@vivo.com header.b=VZDaXl5X; arc=fail smtp.client-ip=52.101.126.38
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=vivo.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=vivo.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=vivo.com header.i=@vivo.com header.b="VZDaXl5X"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Gl4BjwfusXUnh8UK7LY77DntQCu3NMNsCVMlefIb3XlDClIMG5oUoFS4u94PwHg5SdYaX3uKoJBE/dgUOd+QWl3lx/xT0k7Lr/wMXE0r0NfLixknHCd63mHr50Xm+kXlJVh4C8YrGR46QvJC5PSUN6phjaENAsImwTMPlcPSNu9h7LVMjYdvJFtYHtdl37eO5ueP3cfmF+5ds2r/BBSCOd6ut3+M02ge+B3NykdmlBDVhh3zjJSNnvfHnENdVVAmrLsPmbH1gmukRYGTqy5ZuTFhY+M4wrS2e3pZiLPe47M/qhN8VqG5gWea311va32xidQNYwUTchdH8JnNyxQE/w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=4Fn915DscocWHWA6epXDvba+TqxcI4FYi3oNXToYM3Y=;
 b=Y4XjKFx7dhVTwLcczVvGWGmLwYX8b370ejdZfJgok9o6RYpKCx+/RRvi5em/rR7QTaLJ8Sun4JQM0fqMiMC7ZVu5f8/gM/F9LJqIGtclAOqqK6LxVdR4U719M8nRfHLz5hXlRPAg0KgQOyuRURhmLbUyTZorBixbZ7ahpFNP7YAf2RYW+hoXYxdgOOPx9KVyK6opN11XWVEszOBAbH2tApcQiD0Hs2OY/5l/VVRUurQh8njl3BzAU363VWP3q6Woo/zknbhdHfjzYIq1dQrLkXyIW1XFMemVM/hCx3wbK8rxtg2bgn84QGJz1iGpvSVjjy91503JLEhRYPIgpxvWyw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=vivo.com; dmarc=pass action=none header.from=vivo.com;
 dkim=pass header.d=vivo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vivo.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=4Fn915DscocWHWA6epXDvba+TqxcI4FYi3oNXToYM3Y=;
 b=VZDaXl5XBq7h0F4VmfrLCwveocqbLZpI3MOGVh8X6OEZw+QwtLfjYaX+mprkK8pYXgeyuzUrbDIZSCjzogUgqL9SNpp0XRd68RJn72AGhFUsPwQ6lt4KXaohK5PHNW1QBP+XaTB9GfB3MECjZpMb3cUR22RQHkohrrztdDP0z9iNL/NWwFJocg09pgOlT7YhGJgsog8y0nJU4+AKR/O8RAYhWTZhq4vDsbDd28/b28N+H3wFBUBfDCeM7RGojl6wXEv7Vm0zxNJgkQBSkWI2oLttslwoMrp4Cdci9m8R7i6XE+3nnDFsAEq/Afh7H5jz7bSTpNhdRg1DdAwNr5vVAA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=vivo.com;
Received: from SI2PR06MB5140.apcprd06.prod.outlook.com (2603:1096:4:1af::9) by
 TYSPR06MB6361.apcprd06.prod.outlook.com (2603:1096:400:42d::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9031.15; Thu, 14 Aug
 2025 14:27:04 +0000
Received: from SI2PR06MB5140.apcprd06.prod.outlook.com
 ([fe80::468a:88be:bec:666]) by SI2PR06MB5140.apcprd06.prod.outlook.com
 ([fe80::468a:88be:bec:666%5]) with mapi id 15.20.9031.014; Thu, 14 Aug 2025
 14:27:04 +0000
From: Qianfeng Rong <rongqianfeng@vivo.com>
To: Paul Moore <paul@paul-moore.com>,
	James Morris <jmorris@namei.org>,
	"Serge E. Hallyn" <serge@hallyn.com>,
	linux-security-module@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: Qianfeng Rong <rongqianfeng@vivo.com>
Subject: [PATCH] security: min_addr: use max() to improve code
Date: Thu, 14 Aug 2025 22:26:53 +0800
Message-Id: <20250814142653.283355-1-rongqianfeng@vivo.com>
X-Mailer: git-send-email 2.34.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: TYCP301CA0085.JPNP301.PROD.OUTLOOK.COM
 (2603:1096:405:7b::7) To SI2PR06MB5140.apcprd06.prod.outlook.com
 (2603:1096:4:1af::9)
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SI2PR06MB5140:EE_|TYSPR06MB6361:EE_
X-MS-Office365-Filtering-Correlation-Id: c634e431-a9ea-4d50-2a42-08dddb3ea3c9
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|52116014|376014|366016|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?CFRgJO1GEzuVzqrprxzDum9Cgnmnj15RNdi6WOsvZr1k7NsmtTH4alVHhPJx?=
 =?us-ascii?Q?byL/SAodAdccuiAQ7PfYFFo+BGBXvtJ/HikP0iSMfiBFRrK+0ywSBBeLuwje?=
 =?us-ascii?Q?b1yLAxKaxB0upe4eiStEdw6U86nTPXrWK5/ILZc7T3uQKDZIHdIei0Rs6Hpy?=
 =?us-ascii?Q?vMtAO0p9w9VhB53NAOi0t9AycCTl2dWMsAPJj6xG3HWz2nhZH35Uwb364wP2?=
 =?us-ascii?Q?t4giCzfs6+rGtbdj0aSZRfZvFmo1096nXD1styt6eXZTENxkdds7ugR1euLc?=
 =?us-ascii?Q?IjLYGs/T26s2tvqVTIfeb67HcxLqRbmoHZSux8sBeV10i/y7162Y2bT8bl54?=
 =?us-ascii?Q?TO3QK3XUHxcN9XDcDpjQmFmn7mWpwxbjyKflx0sPqA+drsU4draQqJfVbg9D?=
 =?us-ascii?Q?Iv+j1hUKOQQCJQv5McSBVlgd3s9Nlmg+FZoRt9fRd3ga1d/PTU9vJF9TblSd?=
 =?us-ascii?Q?WO/6Bwn5MQc9/aGC0MSIWd6iIiNiHlxE4OPx6CZ80NuvFHczbTyuYXg28z1n?=
 =?us-ascii?Q?euvLB71d/XKhun0DypXbGX249TQsIsmDBdKB/F15pDQxceF5SAXmKlJ3s6Xx?=
 =?us-ascii?Q?il3c5xc+XvVW9lHUOYydJOwhV60gJTfnNL5nEMDkIZC/HLaIWqIwD2SWs9y6?=
 =?us-ascii?Q?8IVrcKUjwGyIGjbu0P3pQQ3xvs38/J62dhJfrNNF3mOC7Zk3eYMS/ylXQzfU?=
 =?us-ascii?Q?NIvNI6+MvW9IchKYdJSR8Fx/o/WzoeAJMv6vQzSZ0JLaP6AGXTb18afH4AWv?=
 =?us-ascii?Q?70HIM1iF5QUZRAXARw9iMg57FECGAnIv1REx0tCC71faC7PVSCtUpJ4StTKL?=
 =?us-ascii?Q?e1pb6G5OFh5IK8F6kYQDAiBU2HvJLumM058q7JKdQZdV/qX60z95cSh1srQ/?=
 =?us-ascii?Q?hJgO4tb4KW4gUug+Hh+YHzJN3HE6SCblskTeckqHl/ulq2deyAuTezbWiksE?=
 =?us-ascii?Q?09bVFs8RrR376vJB49cjZECITFp8ZeNmrAAHRPrB3znS3lG+Bdl69JZO+jQZ?=
 =?us-ascii?Q?OQr8QVA899xm992EmstKJDBJST19JaxMfsms3Ve+Obr7d12Esd8gB8cKkmVS?=
 =?us-ascii?Q?7ZgXSMaLuDhpA//cCQcZMcB1xPpMkymL7NYqtouOd+AZh3oH4eo0Q4d4EMeU?=
 =?us-ascii?Q?acB9szubDkUdP6V/cIWF9rc/1pRh4PWrz4N2HmPNySkz9fhUx6Kh2cygr7JH?=
 =?us-ascii?Q?vnrb0s4Ti/cOa5LX2db2jcEzPhJYzTC6mQrvNaP+SwZnpc0v+O43DwcOGkpg?=
 =?us-ascii?Q?WSBI3djzW81cmSrrAv9x/4GbgjhwyMhnsi2eIzCqnPS7w1M100tK7O7z5iJH?=
 =?us-ascii?Q?xLetct8cM5XypKWmKTsRjYCr6eyZch0tfkDZSk9s0iIZAGneshABoJwBsoCh?=
 =?us-ascii?Q?3W5dLh9WlUWwhObdKy4basj+Lxg63T4aFg/7y/UcFmVbPMT4I8LiLT+6BjdT?=
 =?us-ascii?Q?Yb/lgdbAF6OXeoL3h97uwp68AijcPQH1S+jVJWIkNM0IJDsDFF9P0A=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SI2PR06MB5140.apcprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(52116014)(376014)(366016)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?ZdURS1jJNou5NF3FkOEgJesPmDaHy0TIiv1h0jJz1je/Dy0cXyKehLH0J0EI?=
 =?us-ascii?Q?2Kmr/ynN1iM9MXcfRBY0Pix0NgUzAenXUo06/3mS1mrYtzfDNL0Dj3gTpluf?=
 =?us-ascii?Q?Aq8Xv8nUZHHnSq95WDYcu3PIXQXR+DOwzcwLzxH9m4QGKTgjbNSCyteT/b3c?=
 =?us-ascii?Q?BfzpRZDcVQwdX5f4Rcupp8kyL+BSg6pEfUjGD47WgC3tJsa1I4R9zImbDXqO?=
 =?us-ascii?Q?x+c6YN3TK32VZjq7o/vgEfFv8oi6OLJGv1sVqkKRKZgGv8TC+A5aVTw/2h7Z?=
 =?us-ascii?Q?lzdW5aQZ+cuxryCvTB3MrrglT6rBk+T1Gy5gTAyri5RLYVf/YPnpdh3jvpeZ?=
 =?us-ascii?Q?Fm6l8Wp/G/F2qX+/CY8SiCpnXv1ohCggss2sxFswe6JIBsX11oDLvgLzTfln?=
 =?us-ascii?Q?CYp5kgVXxGB3tWCh6LyGCKYQ6xhr9yTCe1mAySGg7MhYO/4LzZvPs/JDyIxF?=
 =?us-ascii?Q?hz8LBEX1v/x68cUZ/MYGBo+UEuCzxWVoue5mb68pWMivPIpwfXgq/68a8Hj8?=
 =?us-ascii?Q?8elfLt2j5Ds3Ow/7sXDJ0tBQwd7XO3VtB60ZKohaJTYXJ9eJXBuT2dZoK2Ge?=
 =?us-ascii?Q?M8+eZPUx/PcO+fBN+6l0iC3YhO3BPO+UUmM3+WrBqfL0lwNQhmJ0TW8/13Mv?=
 =?us-ascii?Q?jKIpCAx/+mJL0p2fm5UlOAqsXcP6gVLpsLc8/pVtktxpve8sASIefQ8AGbOP?=
 =?us-ascii?Q?aN1KlN1zSHi0z5wO+k9kYUdl5OTynEro74Vzj74+iq5LMhpWM955zvUjIS7F?=
 =?us-ascii?Q?ljhUrFF4U/hlP4v2HOGBw+5qmg6UqssAoZsDQnRaE4n8YcudPSE4gYf4KxUl?=
 =?us-ascii?Q?AVt8edJM7+s4xGCzoWZ/kU5LZa56WMicULRNw2vyyR4yzvBV7PiU7LrvSQS8?=
 =?us-ascii?Q?ykdm3PG85au7HmWLwtAQ8OFmoGywEQpBr4iS+pzYGzkJuqmTV9yR542Hm0h2?=
 =?us-ascii?Q?aKMnk4BPBJxZqSpTBYWXI4Y0aD9PTBmmtKME1E8Hdg8005U+7wpiyA6IN8y6?=
 =?us-ascii?Q?eEyGxIfHfBc50e+5oSe1gh4KzToPNjbDFbC37lon8MqVIreoCqAouCqXattK?=
 =?us-ascii?Q?RNGp/CTMNMzhTlCZdBpdfUaIIeZc5uRQGuthsbyC8hi2xYdTLKUqKYvwEXu7?=
 =?us-ascii?Q?AALfRj1nOZqPeqtIAJDSc1GIw3iulwFucaT3YQz3UUAYL/RVsjKnxkGnQGU0?=
 =?us-ascii?Q?U68+jUeK9+drer/O3CECAmzfjwodccnHblinahySsjkG6npduQJt3Bssb2nd?=
 =?us-ascii?Q?3wbY5iPHclQLVooet3BuQM8K1QfvKv6oCV0324uZCqVIjPMnKjcBI3BtLwOo?=
 =?us-ascii?Q?Qc1W69BTCKJTRTe+0pCuWmhD6IQ40bE0qZ3eti/wNkZihyWae7sh6//B/Tp3?=
 =?us-ascii?Q?LxVQLzsW5JC49UwtVZMh8Qe3giIadNd67GuUWpkIY8wByz65klxjbdbnmPKI?=
 =?us-ascii?Q?8tUuyxsHQ7yrQLSM2YfMy+wbpBDEGIr0ns1apiZvar7Xr/A4AG5orwckPLmv?=
 =?us-ascii?Q?PFpXk7BPpNhW6KOyjjTfo2xkTovfUmz2VWcUisqaCOhDr196tUeHUJYre0yV?=
 =?us-ascii?Q?dRZSKDe5Rv21Cey6J3YF+pPJDghf7D75TmqsprRh?=
X-OriginatorOrg: vivo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c634e431-a9ea-4d50-2a42-08dddb3ea3c9
X-MS-Exchange-CrossTenant-AuthSource: SI2PR06MB5140.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Aug 2025 14:27:04.1552
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 923e42dc-48d5-4cbe-b582-1a797a6412ed
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: lqJV26jDeXQsJ6mpZ1GVvgpf9TnvEL/d7jycc+O2G7sSfqTWJpcCzPNxwh5ASjmyAkdMm1mpzYJJm5etf8HUTA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYSPR06MB6361

Use max() to reduce the code in update_mmap_min_addr() and improve its
readability.

Signed-off-by: Qianfeng Rong <rongqianfeng@vivo.com>
---
 security/min_addr.c | 5 +----
 1 file changed, 1 insertion(+), 4 deletions(-)

diff --git a/security/min_addr.c b/security/min_addr.c
index df1bc643d886..50035bc9281c 100644
--- a/security/min_addr.c
+++ b/security/min_addr.c
@@ -16,10 +16,7 @@ unsigned long dac_mmap_min_addr = CONFIG_DEFAULT_MMAP_MIN_ADDR;
 static void update_mmap_min_addr(void)
 {
 #ifdef CONFIG_LSM_MMAP_MIN_ADDR
-	if (dac_mmap_min_addr > CONFIG_LSM_MMAP_MIN_ADDR)
-		mmap_min_addr = dac_mmap_min_addr;
-	else
-		mmap_min_addr = CONFIG_LSM_MMAP_MIN_ADDR;
+	mmap_min_addr = max(dac_mmap_min_addr, CONFIG_LSM_MMAP_MIN_ADDR);
 #else
 	mmap_min_addr = dac_mmap_min_addr;
 #endif
-- 
2.34.1

