Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.85.5
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1794491231;
	b=Q7CD0HNVcmKdhdYcwBgxePCOffE0oecGVhN0VDb9SHa9X9eLn4ejS6ZN0t2CtpRouoYE
	 zboHy+gJzMQEV95Bigo2t2PiuJzAF6HJ46W1RwmcCOie4e2Ylh8VebFf9OWl62aANPh6H
	 Nlq0yn8eo8fKMtPCTIqkTpeAKkuyQDWToRVGOkVev4b5B5hU4fKkBy0x9mPfRTjh7z3jj
	 UO8tJZ+JA5CDxUbaC1BeJECsyAGSEplI5Ok4uPqQYhCVmMRmOAbFMCFaroSIXn5SooZSc
	 iQ+ySviScYVLs5Jo8e6BDgYN+/iqM0fue81h5zldN9LASNk95eSKimRedbtBV4CVMTg==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794491231;
	h=DMARC-Filter:DKIM-Signature:Received:Received:Date:From:To:Cc:
	 Subject:Message-ID:References:Content-Type:Content-Disposition:
	 In-Reply-To:X-ClientProxiedBy:MIME-Version:X-MS-PublicTrafficType:
	 X-MS-TrafficTypeDiagnostic:X-MS-Office365-Filtering-Correlation-Id:
	 X-MS-Exchange-SenderADCheck:X-MS-Exchange-AntiSpam-Relay:
	 X-Microsoft-Antispam:X-Microsoft-Antispam-Message-Info:
	 X-Forefront-Antispam-Report:
	 X-MS-Exchange-AntiSpam-MessageData-ChunkCount:
	 X-MS-Exchange-AntiSpam-MessageData-0:X-OriginatorOrg:
	 X-MS-Exchange-CrossTenant-Network-Message-Id:
	 X-MS-Exchange-CrossTenant-AuthSource:X-MS-Exchange-CrossTenant-AuthAs:
	 X-MS-Exchange-CrossTenant-OriginalArrivalTime:
	 X-MS-Exchange-CrossTenant-FromEntityHeader:
	 X-MS-Exchange-CrossTenant-Id:X-MS-Exchange-CrossTenant-MailboxType:
	 X-MS-Exchange-CrossTenant-UserPrincipalName:
	 X-MS-Exchange-Transport-CrossTenantHeadersStamped;
	bh=PUlRBfgzYF1ywaPj2GNojck8YjiOrY91OSotwhOUQMU=;
	b=uFUy3h71XCxvmE/hh2ETk/dPtlCp2Sh8qtHxnx2eaZgXKnhfvSdE6tVfUX/PHZirr/2n
	 de/tT1iUarQKgTLcNFPpF/aCmG/u5KJ2TO/5xkYZU7LgCJrnEZYd8jJRwI/eSGNRqO2hV
	 PlMX4XnVqZbJERY6ztgWJ5eFXjIxCniRMlgBdTwr/F/5ECtAhEmJVa5KZolywARsVlBgv
	 Blo6hKjTp9PLFn6swUyf7DGH74VGdVhSbyzo8syTvEkju/1CckyDOxGLlo8QCntt4miye
	 lMCWrqqSAFgCzRyhkuxuG9/Ohd7UA2KQu0ZGA15VOhIcdaVMekYtGfjbXNepSYHMZbw==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=nvidia.com;
	spf=fail smtp.mailfrom=nvidia.com;
	dkim=pass header.d=Nvidia.com header.i=@Nvidia.com header.a=rsa-sha256 header.s=selector2 header.b=NuV9WqmA;
	arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.85.5
Received: from BYAPR05CU005.outbound.protection.outlook.com (mail-westusazon11010005.outbound.protection.outlook.com [52.101.85.5])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (secp384r1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E5426606A338;
	Thu, 12 Nov 2026 13:47:10 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org E5426606A338
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=Nvidia.com header.i=@Nvidia.com header.a=rsa-sha256 header.s=selector2 header.b=NuV9WqmA
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=zPDKyczj6iIFYnK0r9zgrRBDozdOu5rf61DU0/baHzac0oLOlM5LmRQKtaOW9HXBA5HfHOyu6nwkxGxu5bCHAzfaJkFBwOzWluW8qKm3K+i59N1LZHa8vuJNxfOB2L4U3H6/ndYrmyUpi5B+k5ddBhobW6ftZc4O+M2LS/TZhMIBrELZntPU+V77dE01+De6jhYFWpNzfvWZhWgtT7rnK4jvcTGxem2E112xoDhAB79k1pDqWZqy+LzXrddvJSfHgYKX+1kuxw7dF7lb0wR8NrWW1FGBZ9PFcjvWoBLT/lbRaqv3XDuPGoH1wrsrQfGzTkehs1XvRcY1x0USMhrXmQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=PUlRBfgzYF1ywaPj2GNojck8YjiOrY91OSotwhOUQMU=;
 b=pL6Wv3+xiawITKxyl1QxYHWBRikQr0W0RYSMufF2CXCYze0TpXB/ldCMKdxHSnCznXTRziXLQ5hXz+0EEtUdoN5D0jwKxzHJB3XEL5rNOMlS+OPgXiCbkq3zDNOCNOO/YG2llHkcxu3/YuXYw2r0RRELZDK1QBIqeTFqdoz8QAJ9n4u6PaDxKIsHD1rHs0u9Co8M5i3cb6eOGCiAl5/VJq6oS8p9UAMaU4b4HOTB75pDcmC7dXAUE6g5FExagWmD2BDBmo78So8ICb+lV+IqWjR9JBgxAwRB4e8KZoA5fFV/1PssUW8VkpfQWyOcfsZQ1Mx4J5QuWd1HjZCOg5zRMA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=PUlRBfgzYF1ywaPj2GNojck8YjiOrY91OSotwhOUQMU=;
 b=NuV9WqmAQY9antdnSWlw1ogMfM0gSN5RdkuxqIE4bGCw0IxlzE6zVMcv0JIdM5k8DI1yXZmZnDurzpl4O20HR442PbTKw3ybLar1vyk6v9A49kDvJm1XJICkwK7VVzc6zvo4cytkOanhe22cYyKJICVhz5jpKE4qzEzCLYkfgwFwkN9uPCDvn7WNsOAz9QO9xYKk7FVjxsWXKRkFYcD4YCYgEwDUvx0mSo+Q7BiBnRH+/rPc7lO/Xzf14NWlezwTFrjuPm3OIopVrX2DNodZOObU85++8DaWBaNJFhRzd+m541jApqkV/ctAosVgQsO8c5McrZhD6wO5y7GTwQahTQ==
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from PH0PR12MB7957.namprd12.prod.outlook.com (2603:10b6:510:281::22)
 by SA1PR12MB8985.namprd12.prod.outlook.com (2603:10b6:806:377::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.615.9; Thu, 12 Nov
 2026 13:47:07 +0000
Received: from PH0PR12MB7957.namprd12.prod.outlook.com
 ([fe80::9251:acc2:cc63:3499]) by PH0PR12MB7957.namprd12.prod.outlook.com
 ([fe80::9251:acc2:cc63:3499%3]) with mapi id 15.21.0615.009; Thu, 12 Nov 2026
 13:47:06 +0000
Date: Thu, 12 Nov 2026 15:46:45 +0200
From: Ido Schimmel <idosch@nvidia.com>
To: Eric Dumazet <edumazet@kernel.org>
Cc: "David S . Miller" <davem@davemloft.net>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>, David Ahern <dsahern@kernel.org>,
	netdev@vger.kernel.org, Paul Moore <paul@paul-moore.com>,
	linux-security-module@vger.kernel.org,
	Kyle Zeng <kylebot@openai.com>
Subject: Re: [PATCH net v2 1/2] ipv4: recompile IP options on a private copy
 in ipv4_send_dest_unreach()
Message-ID: <20261112134645.GA3195113@shredder>
References: <20261109131736.3060756-1-edumazet@kernel.org>
 <20261109131736.3060756-2-edumazet@kernel.org>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20261109131736.3060756-2-edumazet@kernel.org>
X-ClientProxiedBy: ZR2P278CA0005.CHEP278.PROD.OUTLOOK.COM
 (2603:10a6:910:50::10) To PH0PR12MB7957.namprd12.prod.outlook.com
 (2603:10b6:510:281::22)
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Post: <mailto:linux-security-module@vger.kernel.org>
List-Help: <mailto:linux-security-module+help@vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-security-module+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR12MB7957:EE_|SA1PR12MB8985:EE_
X-MS-Office365-Filtering-Correlation-Id: 46c12457-891a-4f8d-9287-08df40c370d4
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|1800799024|7416014|23010399003|376014|22082099003|18002099003|261009223027099003|11063799006|56012099006|4143699003|261028144727099003|261021121427099003|261102130727099003|261102123227099003|261026140227099003|261026121527099003|261022105027099003|261022075727099003|10067099003;
X-Microsoft-Antispam-Message-Info:
	dhY0OLQxcRCq6ShRLKZYIrXsLf8qs47YoKTugxojoy3iEOBEdeUrfEb8uGZkUdibWLVI+EvphLMwlHT+sl+Rf2o5QetJL8pKA0Ef+lxnSNtVkfGCXswJYyQnSW2r50Gdl+taJ3itCgYkFenS9ymj3YovlXNUs2TviADDM6sryhtIkaxsHBbMxZl+Grb/SOsuDmoZlInlWaN57Lyv7FhSN8NJpBpP2vZInQ1VPlJSMqdBxQP04sKUPxA65wR0axN+O/35hXVe/7cKvzi/kTC2koWX2VoXK56dLFtvpNuZ1DSDBnuYnAYH5h82x9eza/st4728t7Iz2UdLxY2032glG3DhIWaIxQuQFtvTBGwdopPW7/NehpRJwuvNVeFCK5MSKk+urJPkAtr9tg2eQPxidwHjfv7okTIWnNY6RSEt4y06HO1plNMrCYy1HN9Yk6VCmH63AKRlz7BCDz3HQb0fhPRwBm44Ypfbe/L4srbEdtiqVPhFk4bwzZhB64v8Ks40c1OVOnfqxczMoSejo1Me2Hh0uGucZIJwNi/1KsWATbK10o+0WNnZmOsCb9ix/7b4DT54tjgMXRh81pwJg1mdcBzFsBZDpEMClcO+uGY2xcjgqn6/36pSjF99R6EsBDwz6WwWFJOoA6hgPpr0S8TKBGuqnadh+t/AGk7NrmQrDoo=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR12MB7957.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(7416014)(23010399003)(376014)(22082099003)(18002099003)(261009223027099003)(11063799006)(56012099006)(4143699003)(261028144727099003)(261021121427099003)(261102130727099003)(261102123227099003)(261026140227099003)(261026121527099003)(261022105027099003)(261022075727099003)(10067099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?/A0DtvRzsTDsa8VI3H51uFUf9WvLM0Jiq2iWvXn2r7KyKV1JCgo4n1/8lpTC?=
 =?us-ascii?Q?U+2lPzunad2I6FOFHQEwSMLfyeykO8JCIAkO2IJ4hzbYJjwMS+9OkPl8Z5AI?=
 =?us-ascii?Q?OeUjX2a9AkfN7/c4kVcZQ/6vPToF6KB44cZuysDGNvPuuf+Ww4GJHqiD9EF1?=
 =?us-ascii?Q?P4NsmV8wntArsxrsXa8sne+hsvqixhstJeheNtbCupsWeKLqRMm1fd7V6miw?=
 =?us-ascii?Q?kMromKoMiuFrgMsVOt6/9dgQuOIsVulFZraHanVw47qfuCLRUQTgTjsW4BOT?=
 =?us-ascii?Q?1AD44QMvmyXWgd2FPGNUYxEFmtkJCoJ17YDCqVLLLd3AgIGrSE6ta3mtw1MM?=
 =?us-ascii?Q?5b5zI86euFIHIXdexVF2pQDKmDYbUEgOK83Wlwx/QSCbxBrEjodbiTIjUC8G?=
 =?us-ascii?Q?P0WkaO1OMNYq4JsDShuR3UqvRttPMwXkmulqVoT+HuNXpsiHmCQ16ly3lO08?=
 =?us-ascii?Q?coZEz9hoJup6o0V6GaMT5/fUBTzUTXkZaWQY61fjfikuSI4EtlHOuqDjboMZ?=
 =?us-ascii?Q?5PMS8Fje/jx0uWuwGdLf+cz2e6pAL5FR7YspjRq0JnDjNz4MYRtMkACr9g+h?=
 =?us-ascii?Q?Y1Mk9llZHc0v9Irko5MSYTqmqd+iAhMQaPRAWvRbPMbCak2Xh7Gi/Y8gnpqE?=
 =?us-ascii?Q?+m41IDpGUNJmO+VFntW50QTMXkPj2s8kOTkI7EGiEgfUOeqFqSL9rIBnVpFH?=
 =?us-ascii?Q?zLimU2j27acWEDqA/OKVbT+dbCtbZLLdd8D7hKxkVSy8sPmRebw+qYmddO7f?=
 =?us-ascii?Q?gHh3nf3O3BChmlpwhGLcqTPmonJ1vdGIhFFysR5E2jXnBs8lvOmPixgAN9/I?=
 =?us-ascii?Q?TDnbIKYjX9WxVha5s19VhE4vSEqfPCG6e5U1qk+Q32SbVv77VFU4YgPrEA64?=
 =?us-ascii?Q?k9ePl+5k37okp+Bh5YKiUrvcH7/D1hiVY4UPcJ/RSisOJvtUVhPK02T1sKPV?=
 =?us-ascii?Q?PrXw/u9X5YXRmjZTTcOEzzNOjeyiG8oOeUpvX4T6TavsyuHb+iKEyoAZXRMZ?=
 =?us-ascii?Q?1F70/Uh4dROlqaqflUxKGwy7V/K7CfVldD/d+po0O2/lV5R0qO4/LdnyDttn?=
 =?us-ascii?Q?ocbIlnj0ACkQ5NdNm9VcE9SOQR3jL8yckjV34dChucIP0cMdf67JoLZH14TK?=
 =?us-ascii?Q?j+IcbCD9pQBkI0M8rV2gtYwq0V2Wpqumr0J6rpOhhkSavMs9u7dOvOvAereJ?=
 =?us-ascii?Q?T7Dz5OtiSZ6Xrqf/R87PQXPNypgtdNb3oIRXDJ93ZnZSEoqSWF4FOVCaezP7?=
 =?us-ascii?Q?pal7NCauwzGEinGUOnmayE3xLtSPm29ZkBLj/aUobIO4QPO8nEdeRgRXxGHA?=
 =?us-ascii?Q?V7XcxSQBfAIGFS9z6rzcSSaU06yzIa85jq5XKJ7WUKmWYHsH/dlFSV0ZYFfM?=
 =?us-ascii?Q?USBS+T/Jbk4bFPJEZVtpfPwc6DyiB/fhDNyGqgtRtPVbBQjeNgyFdbw+zvqu?=
 =?us-ascii?Q?fbpcUjpyuX4VNP58O8WNRkobxWGkhi6urMWRbRouX9xGYx++qq9A8TIdKKal?=
 =?us-ascii?Q?OmkX6zc/3AFMCSyJQmDUvYC1JNd1R6NAYPjZ7jrGRl4+8hGk6Y/8YabR9xx6?=
 =?us-ascii?Q?X2laoODbVeE5/5geYn/KT1XOJrvxBx+kIN2vbUtWYdtfPDsLD6RL80SBgfna?=
 =?us-ascii?Q?jNxj+OW2W4i6ewQg7HmDMl2df9Dv/wlG3cG+04pAi8vI8vTcbFYIxno/6rvv?=
 =?us-ascii?Q?15ovY/WzLQRUh2Nybf+Dy5ol06kzkUW6oB0ycybMmWlMNTRw?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 46c12457-891a-4f8d-9287-08df40c370d4
X-MS-Exchange-CrossTenant-AuthSource: PH0PR12MB7957.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Nov 2026 13:47:06.8288
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 0Ep48jH9h84iA+FRXbjSswe2bWfk77KdSIe4CxLauTP289yaPKYbtv70b86hTH7m7OKt878nkucs5Tm7p7g4Lg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR12MB8985

On Mon, Nov 09, 2026 at 02:17:35PM +0100, Eric Dumazet wrote:
> diff --git a/net/ipv4/route.c b/net/ipv4/route.c
> index 3a90c8d28b940bf615c165d9b30ac634943586e1..9af72cb892034deff2bb3169911c02c025d73cf2 100644
> --- a/net/ipv4/route.c
> +++ b/net/ipv4/route.c
> @@ -1256,6 +1256,7 @@ EXPORT_INDIRECT_CALLABLE(ipv4_dst_check);
>  
>  static void ipv4_send_dest_unreach(struct sk_buff *skb)
>  {
> +	struct sk_buff *nskb = NULL;
>  	struct inet_skb_parm parm;
>  	struct net_device *dev;
>  	int res;
> @@ -1271,6 +1272,16 @@ static void ipv4_send_dest_unreach(struct sk_buff *skb)
>  	if (ip_hdr(skb)->ihl > 5) {
>  		if (!pskb_network_may_pull(skb, ip_hdr(skb)->ihl * 4))
>  			return;
> +
> +		/* __ip_options_compile() writes into the options, and
> +		 * callers of dst_link_failure() may cache pointers into
> +		 * skb->head: work on a private copy.
> +		 */
> +		nskb = pskb_copy(skb, GFP_ATOMIC);
> +		if (!nskb)
> +			return;
> +		skb = nskb;
> +
>  		parm.opt.optlen = ip_hdr(skb)->ihl * 4 - sizeof(struct iphdr);
>  
>  		rcu_read_lock();
> @@ -1279,9 +1290,11 @@ static void ipv4_send_dest_unreach(struct sk_buff *skb)
>  		rcu_read_unlock();
>  
>  		if (res)
> -			return;
> +			goto out;
>  	}
>  	__icmp_send(skb, ICMP_DEST_UNREACH, ICMP_HOST_UNREACH, 0, &parm);
> +out:
> +	consume_skb(nskb);
>  }

Not sure that what Sashiko describes can happen today, but I wouldn't
rely on the network header not being in the headroom. Something like (on
top of your patch):

diff --git a/net/ipv4/route.c b/net/ipv4/route.c
index 630143ca0f31..77c03620f89d 100644
--- a/net/ipv4/route.c
+++ b/net/ipv4/route.c
@@ -1282,6 +1282,10 @@ static void ipv4_send_dest_unreach(struct sk_buff *skb)
 		if (!pskb_network_may_pull(skb, ip_hdr(skb)->ihl * 4))
 			return;
 
+		/* pskb_copy() does not copy the headroom */
+		if (skb_network_offset(skb) < 0)
+			return;
+
 		/* __ip_options_compile() writes into the options, and
 		 * callers of dst_link_failure() may cache pointers into
 		 * skb->head: work on a private copy.
