Received: from APC01-TYZ-obe.outbound.protection.outlook.com (mail-tyzapc01on2083.outbound.protection.outlook.com [40.107.117.83])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 33DE6188909;
	Wed, 21 Aug 2024 07:22:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.117.83
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724224978; cv=fail; b=ByIdQ3t34YHoqgZ+HgnBIycwgcSMS7opuLLqQIcrgNlZJs2mCDfM4G0Jzm3hrVv6sddY/iT/+KPlNdlzbx/FXfirNLn3xs+gdnt7jlXB4d32X5qM++cdiSU5JkerJ8nVIgP9wpwHwTiV0MNMI7+yMnpHP5xD4HhwoQed9QfNcto=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724224978; c=relaxed/simple;
	bh=3hlNCpO/xJNT6n98fjZv7pdVdhPzVIAQcJAqZByK8Rg=;
	h=From:To:Cc:Subject:Date:Message-Id:Content-Type:MIME-Version; b=SFft3qSQGYkYZLwfFMEpxhp0oixX1jk2xCgMjvOgoPjUSz7eR2/D0lF8PTSWWCxbTZ8Mxzz/FKAaUOEV0ehDgwvKKeKQpvt0kVZtKGUyhc7tLgY5zMtHSEYHPS0CoN+Iz+joNLfzBA/ERhD9K3UZN/VZ+D+Ji+I+gQ4R93D2jio=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=vivo.com; spf=pass smtp.mailfrom=vivo.com; dkim=pass (2048-bit key) header.d=vivo.com header.i=@vivo.com header.b=OLj0aWj0; arc=fail smtp.client-ip=40.107.117.83
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=vivo.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=vivo.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=vivo.com header.i=@vivo.com header.b="OLj0aWj0"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=CESI+pkg6FGn5JD3uXvy7GySbdFmM/vggE4c9zYTWMYICxYMSMrbrYknpPsapcR/HGwcaFYRKNMCcuXFLsOhdUQYOoUi51uTaIBV5Vaa/O4rotehfuynl2xGoRVr6qsGWpmliD1f45RVOnDqTaOQPSnJ+eJxhWEltCf8Z/SHtFXqnO1o0FVHMnTZR2zTi4RyV5MXciCHqLMYTtLNumKMnXdxVYZSgr3qudWvYY1G/G76yo26B9t2RvGSQHSSOuNn9aupb6UDotPL9naYqMCZBwQfqTD3MrmrxIYv+qQ6XXELPcIZRo7x7vtJIvCxrA0Mx37/OANE047Ce4MnPqlkeA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=PobSDjULB452e2UmkrK5PkJrqQR9imyUF6eaBkRo1D8=;
 b=ecEH9KgwTqhf+QaWy/1/AcJejgY3LVoRuMBdbP7KPPy+WZtr/RVMHwz8J59ujcWHC4/Si0WPLZDkYfTRD7lvZyzbv/0KuNgwTJfaNyd2Q7KXQsIPQE1R1wySBsIGmfShi+5Hy/PyGBNeTArZCmGbAlpLVecAD4uD0068o/VzgiK1YyiHpVSeUYJ/AC1qAC4MCP9HGcZWubfiBGKqbZHHY81Neo0dkVGe1bf+PhTMiSFBonto4BdtXSGp+smf8lFALhLPrDPvHkFRbT53adiZJhk0kKEpiyOWGQvTZ5WUIz6iU0D+zV9sUu+Fuzn5iedOOAaCHHtTb5V8et1HfCGW+g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=vivo.com; dmarc=pass action=none header.from=vivo.com;
 dkim=pass header.d=vivo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vivo.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=PobSDjULB452e2UmkrK5PkJrqQR9imyUF6eaBkRo1D8=;
 b=OLj0aWj0pU2GG8FL1VDfC8bXsObsKki9NQQJpM+d0I32G58jSJobnKJvXNFD8RlR4UkF86OWjwfg1fF9uvv5OYWwKrNwbdAsEBwFfpB4gLRHiJ7t67NVulCr0NHB2aVANOrfOOG8HFoAlOxW3eEnsthItO6kpweNAxPCjIdp4WZXzmhQUGIqfnoMQc+3d88YoFg810ctNxIFL5NXLqz+veuF0WcovEvJT2ePtxle2THtgl51YvTP+VGET3WhyFcX9cKuqpFpI/uBQKZB1SDwPpA09/zriLI3t5f2/u7twXBgkcpDSZ+uC7nvLS5yQTfr0YX63CW9knDjz+S5Ak8s9A==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=vivo.com;
Received: from SEZPR06MB5899.apcprd06.prod.outlook.com (2603:1096:101:e3::16)
 by JH0PR06MB6386.apcprd06.prod.outlook.com (2603:1096:990:17::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7875.21; Wed, 21 Aug
 2024 07:22:53 +0000
Received: from SEZPR06MB5899.apcprd06.prod.outlook.com
 ([fe80::8bfc:f1ee:8923:77ce]) by SEZPR06MB5899.apcprd06.prod.outlook.com
 ([fe80::8bfc:f1ee:8923:77ce%3]) with mapi id 15.20.7875.019; Wed, 21 Aug 2024
 07:22:53 +0000
From: Shen Lichuan <shenlichuan@vivo.com>
To: John Johansen <john.johansen@canonical.com>,
	Paul Moore <paul@paul-moore.com>,
	James Morris <jmorris@namei.org>,
	"Serge E. Hallyn" <serge@hallyn.com>,
	apparmor@lists.ubuntu.com,
	linux-security-module@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: opensource.kernel@vivo.com,
	Shen Lichuan <shenlichuan@vivo.com>
Subject: [PATCH v1] security/apparmor: remove duplicate unpacking in unpack_perm function
Date: Wed, 21 Aug 2024 15:22:38 +0800
Message-Id: <20240821072238.3028-1-shenlichuan@vivo.com>
X-Mailer: git-send-email 2.17.1
Content-Type: text/plain
X-ClientProxiedBy: SG2PR04CA0196.apcprd04.prod.outlook.com
 (2603:1096:4:14::34) To SEZPR06MB5899.apcprd06.prod.outlook.com
 (2603:1096:101:e3::16)
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SEZPR06MB5899:EE_|JH0PR06MB6386:EE_
X-MS-Office365-Filtering-Correlation-Id: 6dd09110-0e17-4a86-7eaf-08dcc1b211a7
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|1800799024|376014|52116014|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?hlGT7ftCXksBFcUX4rA0Kdz5kul4kb69vH2OKwQ/W7n++lyK5TMgaV16ch/d?=
 =?us-ascii?Q?scKriFI8dinG95lWHzempikAU3lLzz7EqWBgz42qq2pbl0wnWk01Tr8MGMa1?=
 =?us-ascii?Q?8cb1hcdUkpLNaaE7da4gHT+tCXFXQnHbNJ9Dlj6ogAkcat7S8w2hEzGR79ag?=
 =?us-ascii?Q?fKiUBXCPuSIvLfiqA8UHy7ebq87NfO8BrQzCVlMGlzuyFezA6vkZ6W6tumfi?=
 =?us-ascii?Q?CLXjP291uGJHS+UdlZUU2pOY9KJmJ5Y8Jwp5plVikKpdHhr0jE1K1bUFuB7A?=
 =?us-ascii?Q?nu7OPx+f9pDV1JHAUNcISh5N35ONeFoNRYa1jJ0lDanh2I3CLMraThHpJDaE?=
 =?us-ascii?Q?6rbW+LBHQaCQMxhbVNOA8rK5CDzApA5lpJPgaFdqLoSdaO64AlmNjvGWezZX?=
 =?us-ascii?Q?d7r64ufK/uBzZL6nHVLkM1qQw94QH1Gbn7VK4GQSBm6ZhRHeR9rLyxGr1D6l?=
 =?us-ascii?Q?RRd1jFyVDH8KSD458bt8mU7MAyQwiYo87VoBxTkCj669KOl/11TEBJeCvMWq?=
 =?us-ascii?Q?yhuHsMq3QfCgoXtQnpAYYbGnaupe4sayKl6XusEaV5cMGd1S+yLU6tc3QkeL?=
 =?us-ascii?Q?5vL/RlWhLVjs/Zj3WoXthAqjtofhboS+Xr0Y6dJHFUNEfFN3yTJBemt6QVe7?=
 =?us-ascii?Q?eiBY6cIyctXEBdtVPPsnt0h+fLcdbRvzGZaj7Oyt9HJKucnx7AQX1WNQiJsH?=
 =?us-ascii?Q?hJ8CTWoJVqOhkMTq+1CN/fz8w1QQVWcra/IBSTm07WpEuPhHtLZ0k2WoLTGB?=
 =?us-ascii?Q?Y4VP+cTE2U8yBvtPvS7SVJEhsEJPcIMDf9/147KDpqthAE9jr1jmSpX2w4pi?=
 =?us-ascii?Q?HXwoQSI8QYTZ6+W6vRqRhuG9RQg7SklC3UkRss+2oWlxIWspSvyOHhzxp5m+?=
 =?us-ascii?Q?GXiCDXd8drqb46ZAYaXhKC5pnCfWnpIjvtOHenZ4c3JKYAUg28ufryFAIlcB?=
 =?us-ascii?Q?Q8JhL3OQCpwZ6B+07BWMd2AmiQBF+HoxwOIaJZ0jDwpTyszBDWgwoGh95S0s?=
 =?us-ascii?Q?7g3Nwat5KYE444p+87UJRTuvaFw4gBGtfWhBemJzCQQQ2njzDIkPnYoaqkBj?=
 =?us-ascii?Q?zVoI8tHId17Nk5PP8rshi/dZR2VwZUd1oxT1deP2dosoOHRLUNgt+dDb/G8G?=
 =?us-ascii?Q?I08et08InkNqKctkhqAOjjJYQrWSlwX8PG/olJSKq2ZXLKZKTI5v3xl5bUii?=
 =?us-ascii?Q?+a6X2qx2fgSxa7qQE8LwOvf2ULe/m43c63W+kDn9s3uRGvgvqMFusat61e49?=
 =?us-ascii?Q?S60NQDISL9pRjygot9rObklqTgTvKgfS+HD74ESBPbzo9PxbsanKyiMe37EI?=
 =?us-ascii?Q?wb7SDfrbrW9zLyIT7yu3pYxKk3Es7+/jWpdLWELtFT3jbI2K4jld+jS/ENdY?=
 =?us-ascii?Q?gcX7VlNgtVRruAUO+Enz+nuLmlhH62YXXcJRLX6IRPV6McbXng=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SEZPR06MB5899.apcprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(52116014)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?8JVrdx1lzZbOMxhvoXIL9I8ZUTnQMzAfoxTwITre0JdSX98kqVZBDsDT/ed1?=
 =?us-ascii?Q?HMx09tOK6HNO6NY4AB9GsdBMr+ZGGxjdNO2gEj3w5J59dg2fUhC61OT1A62y?=
 =?us-ascii?Q?fg8OFtUyBq+YgwXY82jHcT/9CtRpjYxKHKQeyf/sL3yzhC+sKTrUMduiEdRQ?=
 =?us-ascii?Q?WcvXZ3H/K0bquloaQrtl2ZvARYwu/5mIkITrgWnL8CndW6QXoTKzHmkwH/nq?=
 =?us-ascii?Q?APmlEzDCdiTUZqDc8pwWvZgsce7OD5WtL/VtT6OH7yuuM8WrKQpauxCtONNV?=
 =?us-ascii?Q?yAaEoTKgy3Bs4+VEYdPxlTpRTF4ZVqUOTTMbubKPsZZyk5pVhZXd/cQVkjtf?=
 =?us-ascii?Q?gc1syHSRutqIAXrqGL2ELN4vYDhC5AxLCePwOMznA/hCtwWfchECR8DqV2RW?=
 =?us-ascii?Q?igVoiWGCUdKVR6e0EbNgqqqRo0jolZRNVs1fZZ63662+SHrguI0h0Bmlz9jf?=
 =?us-ascii?Q?NltS4rFyupuEgKuDAR+GIncMKyyYrzQ9wtYZ5OfKTh//aqPFgk02WOU18fT3?=
 =?us-ascii?Q?F4bBggmBCE0GEEHOKuK3Za0BRotbJy4hcx5CFZmaBX4awPgdDsl8cHK651pv?=
 =?us-ascii?Q?LghclYHhJ77z5wolWzYyIo1eD3EP9MNLWxr2U9tKC8pZIiPp6HhBZzu5wDeq?=
 =?us-ascii?Q?HzDc95ppTqem16tB6yfYOUnKQehWjYpKiB4GkuAIWTq2wFyYMw2jBM9ajgWx?=
 =?us-ascii?Q?U8tKqXUcglVg0erjGTA9O748bH4KWLfZ/AnF+IGhQpW5WDBoFNSThy5CGl82?=
 =?us-ascii?Q?tloqya9q+dBngCUdWf2QbuGg0qP29cqcw2CEv54oZ1EpeOBq4GYdXBqEaB7v?=
 =?us-ascii?Q?3xytMzhoRgj09eEElFS20IIly5NNPK5ge7xLEFFyZfflm8GLCczoLlhDIFiH?=
 =?us-ascii?Q?1wfSfzjoST0lz418hA8n+6OHYowQ7VHffydqHDq6/iFYhB6QX9zKnJtYQKVy?=
 =?us-ascii?Q?Nrrqg84Uasy8FP3fGYsHTeqLHU/iBhhpBuyyjOXqhRMPUkcg1KCo3Vnw+FRD?=
 =?us-ascii?Q?fWXypjWDzsQicVI0kBFxGyhAo4hjQDki+roVclAlywNEv+nGp84dRos0wAWg?=
 =?us-ascii?Q?DwBcR6izSZVGkK/ChqBQ1TmQYRsOvEhwFVGyrvV06rQPh2OVInFmqHPcE+bG?=
 =?us-ascii?Q?TBmaSY0FopvcxYfxaJRXGwXQVlVa0JPZG6+IKxUf3q5U7r9iRjKwcLKX/PEu?=
 =?us-ascii?Q?Pz0kHwgti4vFpfSrJYqyjAiaTnrI3HLl5Xraqbq8Kr2Tzz89VckhQOtUd3yN?=
 =?us-ascii?Q?r9ypakz9gmF4KWShrr69GsPO0ox7FpEy1W4qLdnVb7B8a/UGwMWxKqbC/lP/?=
 =?us-ascii?Q?U0dAL5jC2d3b8jKXCOdTScm1TWVptCi1kG5IEggt5JGmMm//YHfAoQZU0kS/?=
 =?us-ascii?Q?gCBkl2AapTGAPS1ymSruQJa7XOlbaKN5dDv463qUwHS/D4LdSDqJf8bEVP1I?=
 =?us-ascii?Q?s121PHv/PuxGlEJdBHf81Q2E3YogMDMh3ESLOqHH3SOPCG4NJQ+YOosCZK5c?=
 =?us-ascii?Q?8OKrd41iVf9BXoDsrtPomwNX13rbroXsdn19JsMVzOHcrbjre2dE+sF4+NLw?=
 =?us-ascii?Q?3WoB0l/dqeDe0Y3EvUjRI35y2bwbdJWSMIOAU/mn?=
X-OriginatorOrg: vivo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6dd09110-0e17-4a86-7eaf-08dcc1b211a7
X-MS-Exchange-CrossTenant-AuthSource: SEZPR06MB5899.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Aug 2024 07:22:52.7771
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 923e42dc-48d5-4cbe-b582-1a797a6412ed
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: sPOVc0l5lRaIZAmyKkaepRDDVpezDI1e+Bh5KNcnoLrr/NTQwOKNeMC6H8/oqA0Pz2BD4MPoRdPPKIrkuzhhQw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: JH0PR06MB6386

The code was unpacking the 'allow' parameter twice.
This change removes the duplicate part.

Signed-off-by: Shen Lichuan <shenlichuan@vivo.com>
---
 security/apparmor/policy_unpack.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/security/apparmor/policy_unpack.c b/security/apparmor/policy_unpack.c
index 5a570235427d..4ec1e1251012 100644
--- a/security/apparmor/policy_unpack.c
+++ b/security/apparmor/policy_unpack.c
@@ -649,7 +649,6 @@ static bool unpack_perm(struct aa_ext *e, u32 version, struct aa_perms *perm)
 		return false;
 
 	return	aa_unpack_u32(e, &perm->allow, NULL) &&
-		aa_unpack_u32(e, &perm->allow, NULL) &&
 		aa_unpack_u32(e, &perm->deny, NULL) &&
 		aa_unpack_u32(e, &perm->subtree, NULL) &&
 		aa_unpack_u32(e, &perm->cond, NULL) &&
-- 
2.17.1

