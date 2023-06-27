Return-Path: <linux-security-module-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EC0A7EB64D7
	for <linux-security-module@archiver.kernel.org>; Tue, 27 Jun 2023 02:03:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229703AbjF0CDh (ORCPT
        <rfc822;linux-security-module@archiver.kernel.org>);
        Mon, 26 Jun 2023 22:03:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47770 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229605AbjF0CDg (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Mon, 26 Jun 2023 22:03:36 -0400
Received: from AUS01-ME3-obe.outbound.protection.outlook.com (mail-me3aus01olkn2152.outbound.protection.outlook.com [40.92.63.152])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 681F21720
        for <linux-security-module@vger.kernel.org>; Mon, 26 Jun 2023 19:03:35 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=jXsT7rNWy/wKkz07j4C65ESwc+f2vVhpP6fNuhTqO/grO4mfe2ybtc03p36CnRsaeCEsxGi680Jxkxmt/gtjGLG4wDF7WjSjcWROKkWP7GaV1W8FOIyd/g2w1HdHNc7Ukvde0i7K+blx5a1Zm6Xh8yRZF+iW1khN/PNLMED85nk/igEyx6usLTWPhsg61E/K0PscaWcfhqQlC18MO6Nm8N3mHVrSp+FbRvPTYMo2UP4Dq7/okY2UnzoxNQN2z5oNkP0lBU93HQwm5itLCfAux+nkTDtJ8zt+yrSgHKSXcuTkHxcgPHOes7bHEkHTScnByHV6age+Y2+JpVicf0FQVw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=bi9M8N7Yvhuyuvzk+3sjOURuNSoEaYJwOQtHtMop05w=;
 b=GeLAB/hFUFDzPW3qBi1Byb05S2Iwlk7PA5EYBO8Uny5DaWaqYnfYD7YvxZtilglSNACuqqVkrp+htu6Kgigh4xo81mqPHF2mHw55wYnm9rL1O3ZpVG0oCmEVX+EJEx6jFjr+8sqSeLu1vgkIfau9Tc8UvourxBFv3S32gMeiNoUJQEIO2uCfJMHJyssZ1Wvp8o2AFO3nJOxfQgxYE+YHuZJIHgToexg4PsDlQFXieqUSca0QhZ45GqHgz94VfET2EAliYWb4dsZjkpjV69VFlYS0CQyaQoUCEg2W7HgppAj36BzO8V261p0JYX8OuKP4FvMeknoGQh0C3hQJwjLSvg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=outlook.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=bi9M8N7Yvhuyuvzk+3sjOURuNSoEaYJwOQtHtMop05w=;
 b=KmLzXJ6D7coNH00lMu/A2zTs8iYgH1wWH7OPx6Z/CygA625EeHK0KjwseIrGG5A7Pe4wNqgVXDJRdkRX8rLjnFWTw5GEWLhoRLHfC9cvi93V1Rj4DivRSBnsNopvMORtSAphXO74vs7oxXhRh6V/AzRSt0gtTzIIBd9086jJlFvxB7riN81S6yflA2vl+W63lw1/MafX3i0i4PoLrDglUDPVPrB9GUAm60X0b8nFXwYOSE8vkFu+6qeGPv8EgiDClXhNuM7A7bD1owPHcqsvhclWMW80krznEPj1GFIuRc1vG1LNTufUAk0oQuA7o5iOkZAiSDNcckHWnDXTIqtomw==
Received: from MEYP282MB1623.AUSP282.PROD.OUTLOOK.COM (2603:10c6:220:bf::10)
 by MEAP282MB0374.AUSP282.PROD.OUTLOOK.COM (2603:10c6:220:6c::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6521.26; Tue, 27 Jun
 2023 02:03:31 +0000
Received: from MEYP282MB1623.AUSP282.PROD.OUTLOOK.COM
 ([fe80::b288:55ae:d59e:c3ff]) by MEYP282MB1623.AUSP282.PROD.OUTLOOK.COM
 ([fe80::b288:55ae:d59e:c3ff%5]) with mapi id 15.20.6521.026; Tue, 27 Jun 2023
 02:03:31 +0000
From:   chao liu <liuzgyid@outlook.com>
To:     john.johansen@canonical.com
Cc:     linux-security-module@vger.kernel.org,
        chao liu <liuzgyid@outlook.com>
Subject: [PATCH] apparmor: fix 'Do simple duplicate message elimination'
Date:   Tue, 27 Jun 2023 10:03:16 +0800
Message-ID: <MEYP282MB1623FD643831C9B85EF45064C527A@MEYP282MB1623.AUSP282.PROD.OUTLOOK.COM>
X-Mailer: git-send-email 2.34.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-TMN:  [fD4al7dBJ3Xgit4hUFsBuZUZx4LTGEka]
X-ClientProxiedBy: TYAPR01CA0123.jpnprd01.prod.outlook.com
 (2603:1096:404:2d::15) To MEYP282MB1623.AUSP282.PROD.OUTLOOK.COM
 (2603:10c6:220:bf::10)
X-Microsoft-Original-Message-ID: <20230627020316.6190-1-liuzgyid@outlook.com>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MEYP282MB1623:EE_|MEAP282MB0374:EE_
X-MS-Office365-Filtering-Correlation-Id: 1266e17d-7127-4706-ee88-08db76b2b4a9
X-MS-Exchange-SLBlob-MailProps: laRBL560oLSfarW7hZiU+12j2+vqO2xOy199D2ld44RnOJBVAjRgwP3CVwc20U+Z4OagB+Sd7Bwt3HGovr22ORbR/iaJVXr8EcKIBpjrfHsc8AbtRqaZQED6GEN7kby2Zw4/bQ/Di3qfMQVwBHFNgYLdSNVRJLRfHjwo6SFXFoTIxws/TsU+/ZBQctX3N7cYDRuSjMP8feFf2H8LmLca+65zINpoioyg5u+pgHtZDLi16/lFayciFsofqbKS3K6PYbQZS/cF1ogT18GvNVOeWkoQ2KwhQ/eaQdcnNasrz0orzWe7cpDKvOklaybHylaapZG1Oih8yFccDCgD5ksL7jtNSVkqguorsQjPQsqMkdUnZrTGmZi4dC/aI5NjJJTsLL4StWM/mpwd43NfbCiAvTSOIKNNt6UB1OrD0c/OXNiiuwMQZ/rlOW4iPTQMsHWcmNt10JL5SYKGGHsThfCGQ8W/DGhbKRN2U1dnrCMJik8MIx26kACfQ+Env1Cdg0sAX3HuXCjzw/ZiPZiIousrTrnmswRpTh1YKj6dfcYpdR1g4f8L7RxWN1qacSHjhcID0ek0/deK5SDbtHf6tVtb8JoY9HpAaBk6H5g5vnOQRGOwBKBXR3eWNPa7sGBlvXdRSarx4lRdqoyNxJfxcTiMz+DimMfkK2suWlPMrgK/8lsH/FT6LPV3kOm6Sh5OuPFpCN3ESmJ2rJN46HQzCeQvNpMpcNTlZ0Be5VHGbYsXNnDB5QUOBjKQJ39sCHREf6qeNsJChjWRsYBXkU4TmqMjTOC/CHSkUAvr
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: j28BItZPClwcszF25uGb8I3gNs9inK1JJyPK6PbjrKeLcPKQ0OcTD/xn5fujF7MQWc01wx3/uTuMFfeYfpCUaJY8rSy6ciqYU+pZ7BNPb9nEinHb2T2VEOqtZziQKBSf2RTl1z/Tb2IB6+Okr0H62PmXSqvIu21qbnma5KpVdFU23G9IsZVcSzystOfp+hWjbxfvWRkInInJf0hcO3Sbi57bx6FA/wx14eCVXFoNbitG9w/uTmMDQUYjebWUMh6+xluhRf/xo/CG7py96GKXtEV/SEKGIQBkEp+3cUtkNsxm53qxFkacrA2ZRXiycCdoUvkApXJwK8M9BLVN72hV+QKK4agSP3gr4ssBTBViJlPgeF7CzBCuN3gMoP0mzUxiwG+2J6IsqRzx7yvcVU1kQaLnj/eiH1ap00tLE9lz5wR0Vw8Dqwb7LV2aif8dOOJ2kXoECvEdJ/lUFeBKH0OidsctN2+e97qDt6fzF+OMcUEs44OWWBfSxRuDMZ8YEmoQY0MnxMvq8s8iiPJlMl2N1DeFu/pD97xxA8piPWXwRJN2sFaA9yNUQyApVo7QdOrRN81KruOHlRK97N9Jit8mh7Arhg+L2fPWFYrk+a9RYys=
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?qxaE60Nt+keb1b29R9gbGq2pT1FZkVls6dnst6/Wk73fs3OO7+Q0Wm8o10Qc?=
 =?us-ascii?Q?CNHH5wDV+D5zqE/K4jwOBlvNpj3PpzbLrbtnYG7WnPmqddEaF2D/hqDqgqLW?=
 =?us-ascii?Q?/f+5+P5dVWjrl4exV/JYtbegkDmhMFYmNElXg5uJZ5/cVuGpL2GX3YxWjCBZ?=
 =?us-ascii?Q?Lo5daRBdSQ2eDJfGOmpRsWNxxq+imnM8nFIgfvjMTUiTmVjb/1s/S9vOiNI7?=
 =?us-ascii?Q?114qm+Nhpnlorib7m26N7cAajJFEuwGBkTwikUHF465GTwVzcMvSNz4nD/iT?=
 =?us-ascii?Q?tB9a1/xO6GqpxDNFEmjZREg5GLuWFEiStm8C+Eb0h2pgBYURAgwHMUm+FP43?=
 =?us-ascii?Q?dnEWDtNlhbIfph5Hz6D4qyEQNrf4/gUx+wq3oWHmzffhTTPFUbdoX4yKgT3I?=
 =?us-ascii?Q?dEjmqZzkE+Z6OOTNhON/d4r0WVZkg2RtNfHBtq+4eWWyIUOwLd3rzFU7LW6s?=
 =?us-ascii?Q?HDr9iiAHXpvxW/lBKdCXwmKhk/63ivZrIEifpnWkeXcZB/XQoBiuwipy0/eL?=
 =?us-ascii?Q?Bz10eAkd8zgqICCFvxYOvRs+Diwv85zG/d9sI5/lyIAojOr3HFMPI/LGazWj?=
 =?us-ascii?Q?/6G7CUYl4v3WW5BIW1wL0+oVF80CFmxvuGhaXkzGqYFLdgbkqNLR3rYJHc3S?=
 =?us-ascii?Q?ENluN/O3GkxVCzwOnVxXDrHrrRmnT/D0PzDMi/Xx3dTxX4BLbdd2QeW8ADWd?=
 =?us-ascii?Q?tJop1diEe4nOlWWrGwLo466jN3eEZsbXiYWVzOEk0u0Qg0J6ycY+oDeSu0DW?=
 =?us-ascii?Q?gllb8t4VjeFVlTMghGMJAzDdtNpOQwM3nZ5/77BA5ARKvb0uIOdst0mnussC?=
 =?us-ascii?Q?pj1QFGa5vK8aYv2ZDmkGG5inHeybiptc/rFlLPy5vsLdKJrVQtHXOSpDaT+R?=
 =?us-ascii?Q?04La0sgRBUXlr4DQThvQUWuEgRO3wWNII/rnnV+XDwDbrzfjYsEFc0DzOa0p?=
 =?us-ascii?Q?Uba8LYDgStkiBVppQFzKjAFJEpb/oroVDOmFaVo8c1GUqFQvflnGbSiIbumZ?=
 =?us-ascii?Q?jAj/MUmVbtBEczXj6EtAebdVx0/Wc5btNUpVT9yk6F2TV26D15L7rrvw+AVK?=
 =?us-ascii?Q?9S6zrBWkfCndsEhy3wWL1OvlWNi5W81eEd9q9lWlg/K6i2zBVFPM+Zc/EuER?=
 =?us-ascii?Q?4S1xea9uNcN5OSWz+gzr95psDMmu3qlBToJ258ETLxlVRIfYbrNUde/zqKK/?=
 =?us-ascii?Q?6ScvUEJYfpdgO12zjH2izZ5RH8xdxhRNfi7BvA=3D=3D?=
X-OriginatorOrg: outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1266e17d-7127-4706-ee88-08db76b2b4a9
X-MS-Exchange-CrossTenant-AuthSource: MEYP282MB1623.AUSP282.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Jun 2023 02:03:31.4147
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MEAP282MB0374
Precedence: bulk
List-ID: <linux-security-module.vger.kernel.org>

Multiple profiles shared 'ent->caps', so some logs missed.

Signed-off-by: chao liu <liuzgyid@outlook.com>
---
 security/apparmor/capability.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/security/apparmor/capability.c b/security/apparmor/capability.c
index deccea865..1b13fd89d 100644
--- a/security/apparmor/capability.c
+++ b/security/apparmor/capability.c
@@ -94,6 +94,8 @@ static int audit_caps(struct common_audit_data *sa, struct aa_profile *profile,
 		return error;
 	} else {
 		aa_put_profile(ent->profile);
+		if (profile != ent->profile)
+			cap_clear(ent->caps);
 		ent->profile = aa_get_profile(profile);
 		cap_raise(ent->caps, cap);
 	}
-- 
2.34.1

