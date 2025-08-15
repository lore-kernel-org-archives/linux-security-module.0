Received: from OS8PR02CU002.outbound.protection.outlook.com (mail-japanwestazon11012061.outbound.protection.outlook.com [40.107.75.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8BC661DA55;
	Fri, 15 Aug 2025 03:56:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.75.61
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755230180; cv=fail; b=OirJ8SzOTkuah0eGWOaxh7QYXRyufKuK/8LPNhTWAK2txnQqN1XErw3utncuUCH8pZqhJx2bhdpBmw+pk6E33vHYjcYgcP/rt6i3q8xZWSZgWZ7LNOpxQIHX8+zoL/a0VwWoUb/xTte+6oaAHAjywudArUBZLsQsQ155tHXEoSc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755230180; c=relaxed/simple;
	bh=mW+QE4yoWz1/aUbQHbbMB8OKNjFTUHu38gWna4w+Z38=;
	h=From:To:Cc:Subject:Date:Message-Id:Content-Type:MIME-Version; b=f4myerRXJ4/r/I5WF9dgAqAZT0XwdT3hzR0ZWCOG6Mc8AAzCUT7Ns0dPdN71P0+FsXsATvGIpgAUb7tCi987FC8nd1Pru+kkJ9w0ATyfg6Kuld30MgRIza5oDqsFi34JSVKc5gFwvekjabARNUZvQ3EdizmXl9LxBbI+RvfibvI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=vivo.com; spf=pass smtp.mailfrom=vivo.com; dkim=pass (2048-bit key) header.d=vivo.com header.i=@vivo.com header.b=WHtxXGk+; arc=fail smtp.client-ip=40.107.75.61
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=vivo.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=vivo.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=vivo.com header.i=@vivo.com header.b="WHtxXGk+"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=F1yOjjszCPDBf1Tf4ajqaOxrrS039bXZi/4ku+wWhFaUspvvLt35WBXvbZqu3up3h32oUQ4HcxGP1M8xYdt83dhfjfpdZBOHMRLmEcLK357U33ubFn03bKHrik9kqRw4jVVE8zGaK27IuJVgr2VyjIKdOVHWu2C/kfZcGbnz38L9ECDVHjjvvUmxhv3N20nVuPl9GP3nu/ajZftAVOeD6V8h8hAjEehr+7jxJZwi+S/1gzIY3V4QushPn2nKu7bNT9CBi3x3uVBlcuPz8gSBF/MWzFwlEyRdd5q3YwRWMN9E+d9ThSy7k86e4FpspGKegebcGf0iXD/GOe5ZOzTilw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=r2Lm0UPQVWWxRa6bwgHzu+I/WsCBCXWU0MszzrMEko8=;
 b=hE7x1XQE/K4mZh6D0HU244jVL73+xXPKSyrfyltAMXTNqc+mMm9B36LT7om1OiYCZFm/4NlBwzOI22Ar3apwv7dR9Vj8qfnn27A8aVNmYd0vASVtJHEuJQcXBiJ7Tc/3wwY08QJvGeQBlNlvILdpqqT4vQjR29xMOeKGTNSwr/fN6XJo/6BBpLHIcpcvY2HC8SGf1oL2MxkC6kLGGtFz01bqlCBg3L815uZF0zbEw2y41k+u6PiL7UO4+KPC1w+QbHI8R/2uSN5wbtq0/yAE2d1/vGnkrc0eHojgLakfHUjrby0EDnNMS3r+OetiIIyyXZJhGAojEMpZRhAh4WPkcQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=vivo.com; dmarc=pass action=none header.from=vivo.com;
 dkim=pass header.d=vivo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vivo.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=r2Lm0UPQVWWxRa6bwgHzu+I/WsCBCXWU0MszzrMEko8=;
 b=WHtxXGk+juzclhPsQg59IZQfDwN0x9wl1yrLvEpIiEmrX+Yj65DUZLYrde7sbo4bf+vLABhKn3jNh0m3vfWhIGnGSUmZ0hgHmNVDpi2ge3aJpT3nXUq1csqSu54AjQn9/in1nizOoslQ+eqXZSDEcQ2FlxH3/PLH7vhmIzzDtGefcDZvxNMyEHAe1Lt0jUwLusTB7yfUoLG8+YIvhPksVgeUOQi1Wo+DE6ghXmnmxi/Eu3YOvzeLftGrhoNdG3zN1oAQrcDx8s+g93gfsmLxyjuisJFgqqFWhK086EopJS07SvJAg6gGFd1AZvm6kHSnCg1256WZjHzRnVcLiRm4bQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=vivo.com;
Received: from SI2PR06MB5140.apcprd06.prod.outlook.com (2603:1096:4:1af::9) by
 TY1PPFA3F3F1487.apcprd06.prod.outlook.com (2603:1096:408::921) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9009.20; Fri, 15 Aug 2025 03:56:14 +0000
Received: from SI2PR06MB5140.apcprd06.prod.outlook.com
 ([fe80::468a:88be:bec:666]) by SI2PR06MB5140.apcprd06.prod.outlook.com
 ([fe80::468a:88be:bec:666%5]) with mapi id 15.20.9031.014; Fri, 15 Aug 2025
 03:56:14 +0000
From: Qianfeng Rong <rongqianfeng@vivo.com>
To: Paul Moore <paul@paul-moore.com>,
	James Morris <jmorris@namei.org>,
	"Serge E. Hallyn" <serge@hallyn.com>,
	linux-security-module@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: Qianfeng Rong <rongqianfeng@vivo.com>
Subject: [PATCH v2] security: min_addr: use umax() to improve code
Date: Fri, 15 Aug 2025 11:56:03 +0800
Message-Id: <20250815035604.502874-1-rongqianfeng@vivo.com>
X-Mailer: git-send-email 2.34.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SI2PR04CA0010.apcprd04.prod.outlook.com
 (2603:1096:4:197::11) To SI2PR06MB5140.apcprd06.prod.outlook.com
 (2603:1096:4:1af::9)
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SI2PR06MB5140:EE_|TY1PPFA3F3F1487:EE_
X-MS-Office365-Filtering-Correlation-Id: 51068c74-32d2-4481-5b7f-08dddbafadf1
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|52116014|376014|366016|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?ZIB2CQopSL2c24F1tQiWox9kZoE2qyULSholxA2vCZiDe7rb2TPy18niXAZG?=
 =?us-ascii?Q?KzvoEMZGdqxBdUSgJ4OhSJSaJzGD2WuhFhPDkhdR62IuhC3yxdl8p1JMsr0B?=
 =?us-ascii?Q?8CGQcQhCWZHVjHRBfgPAMGB8I1a92fzsNFGnjjjsDey8H0G1jKOGkHelWg87?=
 =?us-ascii?Q?yWyOAIIca7wg6+CWohVoNlFcatm1LzzHIV8/nn2oIf4fcvl1xmx4MZL4QR7z?=
 =?us-ascii?Q?j3DYnUy3FMYsbM7/IN9+VYzdTI3Wx6jUPhA6JQofMZZ+bn+oWAV/dKjW4Zzm?=
 =?us-ascii?Q?cVBbHTOBG2GhEnatGJGngtRvte/xbNYtryevpj438RbbMd0ULKUfG85Rh31w?=
 =?us-ascii?Q?BI5JUEigbycUQ7cp6mYbWuzNRtGOazJp+jfyUko6VH1Oaf3toIRTDJMVeI67?=
 =?us-ascii?Q?U8/a5DO1+AxT5dIbuY1fzgcL5mDqYv7xyd2KkNpWz8iHFu8hyxxdQ0yJmZa/?=
 =?us-ascii?Q?Vzk5LX3RV5k3Dgch+Ibn5rxjz8Ol4AAdrtT75AZZlF4UKhcTn5yAt1UC82u8?=
 =?us-ascii?Q?78h1hmmvZcwAijhtiFfLZ1jGHIslnB+E3sV3rTqSODT9ggdd0d/vRi1EF4sO?=
 =?us-ascii?Q?AdzGir/SBrhg4zWT9VzxfCKaoBJOGn7r0a9pXpdSHt/eTjFtqHUyj6kspqkV?=
 =?us-ascii?Q?NRKAXk1osWVOwcxnIy9kSW2s+1klDnDPDCP95tPdnAL00SYUVsF21a7X1ZU9?=
 =?us-ascii?Q?bGBOAqadXTam5+7mKAhqcPJNtJD8LUUqhv5Yhaw08XFqJyKQGF56Gr6OBWk7?=
 =?us-ascii?Q?qnLLJEBQKZTMpg8TBXfPLc+SF3t87p6wTztza8E+iU55NUBC8rzA4AfuVhih?=
 =?us-ascii?Q?elj7ugp+yBl0+2HK+w3vVnLjsV7fEtj7L1m4SQWQjlUYQRG2w54+N1CDk+Op?=
 =?us-ascii?Q?wTeoxO8Oqc04P4pYUrjIZF4IQKzSla2sr7rVWxlLYsJs+dQ6h9ydArYlnsK2?=
 =?us-ascii?Q?KMGVKSjmCcNyFaXDpQgZlf0nQyLmOJChix6tOvah5R1z6SUaxIavZl1SxUZc?=
 =?us-ascii?Q?kraKDh9slMnPrw9L21TvnHZt0EqhPZCZQBu6YnCB8D9VlY0nrjH+DcvO25N3?=
 =?us-ascii?Q?ahY9UsVS3GJTdD9e145ktjK1mWlIapBp9Z0f0FNdySGuenvt0A7OiL8cRnAN?=
 =?us-ascii?Q?VIpQAY8l/ayDL2ggr6P4hd3mpV05gEKHYuHTkfOvQk0VsB5vdCWQXsbtrEDr?=
 =?us-ascii?Q?e79NhiqoQ3XEnyOlj9ovEhT4n9oXBNRg6Z1W+NTXrD55YDjUuLCnr0w8qNc7?=
 =?us-ascii?Q?pi0EMB36yH9kO6rtfXizyDT2V0ARA8TnnlQ4qf9v3IKagNlh3JM9nq4glEoO?=
 =?us-ascii?Q?W+5s/sEjZtLpazmpTdTq/WE1h0v1GvuyJjUWk6bulXgN7dtay/NCArlo+22p?=
 =?us-ascii?Q?6pb1z6DKKtXWfoTL9rg9H7i/yPeiA5goV+DS5uJ46j5idBMw6unjIy3pMK+z?=
 =?us-ascii?Q?tP37S5fxRe/fwmmGlBLPsGA2BmQidhdAMro4qPl8v1pmSTO1fR7ePw=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SI2PR06MB5140.apcprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(52116014)(376014)(366016)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?pezBZ6yz/37MZ2MQAWqX+k1dBvnEBhMEfhyGf14oyP9X6fkkPs18nrRqMuB7?=
 =?us-ascii?Q?vrkMgTuOfpGA/uG79j105tSwexiHa3iJbWiCsszC205XZMLoJrSF8WPBbSyq?=
 =?us-ascii?Q?oPXamLB09+8N0ZrfyiaBUqBJhNp14ndzdSgDH3sDxdnwJTybFc44hWXPUgwo?=
 =?us-ascii?Q?SmjADdRy+2mCwf5CnhaEej6xJa3MHJd6RTeJX2ELCTaPqvzL1MDNoB4hKmYC?=
 =?us-ascii?Q?T3f5ke75ZVO23qCjlFv4pDdZw8UstDXSPeBd0tXTJBEisM0wl8+oNBmYw474?=
 =?us-ascii?Q?tqpFlDp3sIjUwABdMYSdfWN0EmCUJFv0Hn4/vymUwiJVurQMufofJAZi1fZs?=
 =?us-ascii?Q?nQpYim33q5s+7yhdiuNWYmmguqv40uJlYo/wuZVozOIyyKyNDp7j48oojHkT?=
 =?us-ascii?Q?jAJrvxgiWuFTXQmXuodMgM3TapPfRKa5NBWFlkHkBq9xPwYzkmk5ft+UCARG?=
 =?us-ascii?Q?bHGVxu0iCGoqxgMnakqsUoQ84ddggfZXYu4WIHeT3PXrQGfE21dhtIln2oYF?=
 =?us-ascii?Q?qTjMGZzPQfSFw/A9J/MkQjerOfjZXA8v5+dg750ki39wYMrHoDXGwQNLP+JK?=
 =?us-ascii?Q?RUFog/vCIlcUsaTPzYGWGMivoCrR4fhRy4tEh8Ng9kavqywl1UBfEAMPDygS?=
 =?us-ascii?Q?rSlXGd2uPmMJRfPITdnS7ml+Ov99fTyPm3SmSHSv6ufN2QXTA9NxSoH9IfPe?=
 =?us-ascii?Q?QoBsxWKAwnOyuhh2xLGuzOSmyLgdJUuq1u8Da8CkS5sHWr7ZHM3Vlfxm4Ky8?=
 =?us-ascii?Q?+5RnOoBWU+kJSlnXshb2wnw559G/abGoCPFRnkfIrH+eUJHWp9DVP7WkCCKK?=
 =?us-ascii?Q?C0gAS0tzXMRSa56JIX0Pk9T8L8W2r3WSrQvG1Jq9PtMsTLjOFiKj/+S/FYEy?=
 =?us-ascii?Q?e6yvm5/cw+om3m4tz1KaVyh7T2vX64qThpPa4gjY9fS98Ab6vHpbMGdV1dOC?=
 =?us-ascii?Q?i5x83s9zZr9FV1e4EQ+/8zz4+8wnaS/sALiCKBU8f67QMqggCUPX6IkHQ0kZ?=
 =?us-ascii?Q?8MVO6+RYT0DiRVuLpK51EepMO/RdHPLNekFeuKXc779inX/YjdqL8hyWICg+?=
 =?us-ascii?Q?5gG3qwvPgjT6DB6Srl33V+A+5Veyz4UUas/GLKFotvOUbke6tR/vIRpf3SLN?=
 =?us-ascii?Q?NokU00HW1qN1BrFDcuiyhbGk3aj6z1SslzLczRJthIS2PgEJplPFQt7/J375?=
 =?us-ascii?Q?u8mtoX7surijpImi/x7G8izlkVRmh1rug3sVPkcVtGnrKqVkFOR4qX9f5Qjk?=
 =?us-ascii?Q?t0Ig5+Kzo56iAPnZ0NOba9M4LzDH1AjgaqX4bT+YgauYkPZR6/ULNrmK1sbV?=
 =?us-ascii?Q?VilyEpEf/zXQDFjie1nZhwPrMOmjEQPkBLKdIol4orj0d/fj5IuInHNnMI3N?=
 =?us-ascii?Q?+NbU6JjBLWoqy8GLPXj0dKkyHNZEZazuM03AfXg9tIp5HUPhMTmwfFWKH9W+?=
 =?us-ascii?Q?q5fp9UQq7DSTh+3tHbHtRHVXDNxwV1Qel1GFclMHOCwYyAWJHJtI0SqeWdVR?=
 =?us-ascii?Q?/1MnWOfGZVA6VBKN5FCmDz8FZLd3zWAoviK/ORHtiJWWMGSuXxVEaVKE54Nz?=
 =?us-ascii?Q?7qXmDmKueCqj8wAt+moqh0NJehsnFA6dIPdOJRZU?=
X-OriginatorOrg: vivo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 51068c74-32d2-4481-5b7f-08dddbafadf1
X-MS-Exchange-CrossTenant-AuthSource: SI2PR06MB5140.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Aug 2025 03:56:14.2554
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 923e42dc-48d5-4cbe-b582-1a797a6412ed
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: tdgNNqrIvoJIrGNXGLE3B84ym60OY4AupF6zk6jm+ZNT9A/sekYW1UEfe+3en19ZxepkToZTxpr7LwhN0+w1hg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TY1PPFA3F3F1487

Use umax() to reduce the code in update_mmap_min_addr() and improve its
readability.

Signed-off-by: Qianfeng Rong <rongqianfeng@vivo.com>
---
v2: Change max() to umax() and include <linux/minmax.h> explicitly.
---
 security/min_addr.c | 6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/security/min_addr.c b/security/min_addr.c
index df1bc643d886..c55bb84b8632 100644
--- a/security/min_addr.c
+++ b/security/min_addr.c
@@ -3,6 +3,7 @@
 #include <linux/mm.h>
 #include <linux/security.h>
 #include <linux/sysctl.h>
+#include <linux/minmax.h>
 
 /* amount of vm to protect from userspace access by both DAC and the LSM*/
 unsigned long mmap_min_addr;
@@ -16,10 +17,7 @@ unsigned long dac_mmap_min_addr = CONFIG_DEFAULT_MMAP_MIN_ADDR;
 static void update_mmap_min_addr(void)
 {
 #ifdef CONFIG_LSM_MMAP_MIN_ADDR
-	if (dac_mmap_min_addr > CONFIG_LSM_MMAP_MIN_ADDR)
-		mmap_min_addr = dac_mmap_min_addr;
-	else
-		mmap_min_addr = CONFIG_LSM_MMAP_MIN_ADDR;
+	mmap_min_addr = umax(dac_mmap_min_addr, CONFIG_LSM_MMAP_MIN_ADDR);
 #else
 	mmap_min_addr = dac_mmap_min_addr;
 #endif
-- 
2.34.1

