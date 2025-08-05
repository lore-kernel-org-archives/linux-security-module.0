Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5469E29CB40;
	Tue,  5 Aug 2025 22:30:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.10
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754433018; cv=fail; b=pj7LJTlEcTC2fPc/WiTXa0t+5sEKH0duZOctW952S3FA2+u0bgvqccv1YzF3bXIJ6XXCDWScfpElMeR888xGM4XNDdJNOYI1my34sM4+8mDc2qxdRj65lCRsltqADVNteu5uCNflNKIL1ePEda80LW7vZytlLO1eWt/J5AZEocw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754433018; c=relaxed/simple;
	bh=SX52lZhaoFfYxUPFeVLz4BzBwSUFtfJ39OkkRbhL7QM=;
	h=From:Date:To:CC:Message-ID:In-Reply-To:References:Subject:
	 Content-Type:MIME-Version; b=ELSjwKSp10Hz+Sz4amuWeGTvrPJKtJei/H3HAmhuk87nHhQ3nrV+mSc5TXlE6+AmEJgkp1t7MK7e1BiTsoX55PsM5GXrpKs4Li7yyGCZ6EstPlwsLfJfb9KrX9r5jCwOT6IolyHuBQ66PzBUE3crcx3LMA0qIlTrwEftdibaVJE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Sq/ASSQU; arc=fail smtp.client-ip=198.175.65.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Sq/ASSQU"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1754433017; x=1785969017;
  h=from:date:to:cc:message-id:in-reply-to:references:
   subject:content-transfer-encoding:mime-version;
  bh=SX52lZhaoFfYxUPFeVLz4BzBwSUFtfJ39OkkRbhL7QM=;
  b=Sq/ASSQUnVdpMUdxDSXBVL5gw4Swc9tS7PSQbE219i1cNKeofEXIAVEw
   yltQfxlRKK7VPaYLsZa5s8c5YFOUgq95h1EiaQd0+0qZMKS6DAhqnnWnL
   PTrduYq+mtvpd4iGZKLOeM3lnGzOCezpw8/XelJjhi+UnKDrHI2flmfRT
   4T3okC8BE8ZeqcVsBbMtXnZ7gAUImOXM0bpMMSS89/g5vid86fZtnq8P4
   uC+nNoskSBAbBptVeZX0GBoGa7F0ipjecyUrnjRUlefpdiX5E2mxzPsun
   YKiEcaaRk3zbctVNpMJqjRStKkgtHsz7o/L1ujmuHIzaOJ4WCsFmyxaZf
   A==;
X-CSE-ConnectionGUID: 5NhqXNt3S06joAIgzIyJHQ==
X-CSE-MsgGUID: 9VeMUOk0SYKwNv1CcOtucA==
X-IronPort-AV: E=McAfee;i="6800,10657,11513"; a="74202871"
X-IronPort-AV: E=Sophos;i="6.17,268,1747724400"; 
   d="scan'208";a="74202871"
Received: from fmviesa005.fm.intel.com ([10.60.135.145])
  by orvoesa102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Aug 2025 15:30:16 -0700
X-CSE-ConnectionGUID: K8zQnZsvTRKikTaM+Cb5+Q==
X-CSE-MsgGUID: ajj+rl3tRB6/YluvbgHCrQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.17,268,1747724400"; 
   d="scan'208";a="168861794"
Received: from orsmsx902.amr.corp.intel.com ([10.22.229.24])
  by fmviesa005.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Aug 2025 15:30:15 -0700
Received: from ORSMSX903.amr.corp.intel.com (10.22.229.25) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1748.26; Tue, 5 Aug 2025 15:30:14 -0700
Received: from ORSEDG901.ED.cps.intel.com (10.7.248.11) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1748.26 via Frontend Transport; Tue, 5 Aug 2025 15:30:14 -0700
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (40.107.236.79)
 by edgegateway.intel.com (134.134.137.111) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1748.26; Tue, 5 Aug 2025 15:30:13 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=v8r5Q2anRDvp796QzhONb86iquE5aYX6DzHWYylt0rAMXkcZigNlVTOizfNKtLKDqgflrrnnNP4ovSaP2ik6s07hn/PdKulJyDgbKljz1w7EqO7K0jqXSxOv5SP7c01dr1Q4y92QV4jwFiTJFz55uPuoFKHL7S8hQpm9kE4U7q0McqGHLNe8dY48hGQuhRRmsv59FbvPJim9wQrmsOliJNL4IlH9MmBrejw5u2U/Vt0nvBMp7NSDAkQVbKSLeAKsOvAA0bb3eOQSPn+0R0mUk02mJ2tFufqAJaQT3qvssUS+sAXNofVIUlroGS4d9wLhCwE58tgH7tAqTQ+e+EXN7A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=c7cUMbmlQc55FbGmf3pAhwBZXf4yiUNz2q0lephi+l4=;
 b=QoJvOpGF+7uqMcxD6aIvOjH3LYHfD9CiFnPPw7DU+zrgdTCEjm9ywRoQdWxj1pQSFcBQHBQFD2YnhMLukWm3X+Izq3ax8mZHHZewPjAAPKrvMkiovhBw/CvnFfG3lSyUwU6dvWcrt11k3w9pkgwUtonIkijZEGhLtYE54frSdb9x8aFFgtrn60kv/uBElFRMOvtvjgksSSDfOwB/gwNBMMd3Jo/dWPgzV+II6MQFS4FJBrVayonUMe5AU/1qh5qLdQ8cG1s+KPNQn/8YoBVsvJMNQ4+ao83qLrKxVB8qq1q93rco55iQAUuTay0opZfgdYkqQ+urfTEeMMDECqZuXw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from SA3PR11MB8118.namprd11.prod.outlook.com (2603:10b6:806:2f1::13)
 by PH8PR11MB8061.namprd11.prod.outlook.com (2603:10b6:510:250::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9009.14; Tue, 5 Aug
 2025 22:30:10 +0000
Received: from SA3PR11MB8118.namprd11.prod.outlook.com
 ([fe80::c4e2:f07:bdaa:21ec]) by SA3PR11MB8118.namprd11.prod.outlook.com
 ([fe80::c4e2:f07:bdaa:21ec%4]) with mapi id 15.20.8989.018; Tue, 5 Aug 2025
 22:30:10 +0000
From: <dan.j.williams@intel.com>
Date: Tue, 5 Aug 2025 15:30:07 -0700
To: Nikolay Borisov <nik.borisov@suse.com>,
	<linux-security-module@vger.kernel.org>
CC: <linux-kernel@vger.kernel.org>, <paul@paul-moore.com>, <serge@hallyn.com>,
	<jmorris@namei.org>, <dan.j.williams@intel.com>, Nikolay Borisov
	<nik.borisov@suse.com>
Message-ID: <689285efaf59e_cff9910066@dwillia2-xfh.jf.intel.com.notmuch>
In-Reply-To: <20250728111517.134116-4-nik.borisov@suse.com>
References: <20250728111517.134116-1-nik.borisov@suse.com>
 <20250728111517.134116-4-nik.borisov@suse.com>
Subject: Re: [PATCH v2 3/3] lockdown: Use snprintf in lockdown_read
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SJ0PR13CA0216.namprd13.prod.outlook.com
 (2603:10b6:a03:2c1::11) To SA3PR11MB8118.namprd11.prod.outlook.com
 (2603:10b6:806:2f1::13)
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA3PR11MB8118:EE_|PH8PR11MB8061:EE_
X-MS-Office365-Filtering-Correlation-Id: 0e21ac7e-6208-4a92-238f-08ddd46fa390
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|376014|366016;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?TDh3RXk1bytrUGJTc1ZyQVM0cEY2Z1hVekxlTzRwNHFBUFZodUhCU2ZQZVpw?=
 =?utf-8?B?TUNUNFhiNzh1bUttRlRhRFB4alFWbFlVQVB3SUhaZUgxZ0pBc3p3Um56QTFL?=
 =?utf-8?B?Zmh0ZWp1SGxIc1ZuRWFqYVNIMTVseStOMjhTemtWeUJDelhkVklZSVBWblVO?=
 =?utf-8?B?bVpUVXhtSGpGVUt4d2k3VWI3SXlSUEdQNGM3T3pPcXY5YkUvZVJMK2w1V2dn?=
 =?utf-8?B?eXdlYmRIaGQ1RURpTkR4enkxb256Y2o1bU5abUFBOGZsSjdVREpGY1E0WS9v?=
 =?utf-8?B?Mit6Vk83NGZVc3cyU0xBZWNYZTR4YlNMZ2RTMTFTOXRnT1dQU1ZUTDRXb2lQ?=
 =?utf-8?B?SnlNaHBBVmFmNTJtRm9ZNVhxNG5TNVlwNWhwK1RQSloyeW9FZFRiL0ROZnBC?=
 =?utf-8?B?SHNtN1ZTVVJMUHhNdmNpcEg2RTRBU2R0Ujg1VlJhSjBlaVhpNk9mSDd3cXhs?=
 =?utf-8?B?VXZwMkRnK2RuN2YrU29POFZ0MHlBcS9ac2xQRGVoZld2UzlHdzk5VDUvckdi?=
 =?utf-8?B?U1p5RHlWOEgwcGlWM0N0Tm96dk9vMEFOM1JsZnhzcnp0OTJYWUlieVlJUDlD?=
 =?utf-8?B?MUJjQXVTVCt0OUczZzhyZ1pMUUtTWVMwN2h5WkwxYnZLN2pQOU1MUTdKSXpp?=
 =?utf-8?B?TEljVm5kdXJISGpIL2loNWs4V3FCOW9MYm1EWFdwRVkwVkxjaTdtMXBBK2lH?=
 =?utf-8?B?UU5GWURGVWluN0NXNm9nWGhnNVNqMEhkb2Fjdk1TSktEeE9XTnRzQzQzUUts?=
 =?utf-8?B?QlA1OFJxeFVvMjFaZm5jN1JWSTFwTlppaTdyUWJwQ2tDU2EzUDhxQmNqRE1v?=
 =?utf-8?B?NTZ4NHVOQXY3aXZrQk42ejhuSjF3SEFZWWJ2NVZiQXhJekw3L2pxR3ZXbFlC?=
 =?utf-8?B?Nk1lRFRyTVc2ZUFvN0VjdTZwdk5UUUVmMlVKV3JrSFVndlRYZmsvOWVxWnFo?=
 =?utf-8?B?YTY2R1dhWGpMdXdkSSs5dWdUZm1aR3NPUmNqNmUvbFZLOG9qZGNNQXFZVVRD?=
 =?utf-8?B?Y2NBVTlDQ3pVZjJnWDliR25pNmlkdkNjcHErTXpaYW1sNkErRUxOQ3RkSEpG?=
 =?utf-8?B?WDBUR2I2cWVPYVNpbzkvclpodlEvZVpZRGNIUUV4dklob1hCL3N3TWR0NmdF?=
 =?utf-8?B?eXgwUGloa2JXZ2kzN05sa2x0SDg1OUx0bHh5YTdVd0hlQUZVS09rTDEyZ29V?=
 =?utf-8?B?M2s1cUxxdHN6SjFYb3pBbFovM3VZd0pKMGxCVWM4T0tiUWNRd0ZZQzltWng2?=
 =?utf-8?B?VHJXVzRPK0djOE9UcWd4elpsUFJLQ1o4YVIwN3ZVT3Exb0Z4bUJOWVVpTVBM?=
 =?utf-8?B?bE11eklpQ1E3aCs3Q2FkbHZHdXNQamZ2SFRDTDdqa0ZXNU9rWVdUbGtMZ2Ja?=
 =?utf-8?B?ckV6Y1VVLys5VWtGRVUvelhQODdnMDVYQ1g4M0w3eHNMelZzanEvRVdzQmx4?=
 =?utf-8?B?a1gwSm51YWZ3OHVxVW1waVVxRTBLd0pHV3dGRG5XWXpPdEM5cDhuTGVzNXZw?=
 =?utf-8?B?WTR4TllZQzJycW9OSTduVUUxUm1sQXR1TnBGTU1OZG1BK2FlbHNiV2R2RkJG?=
 =?utf-8?B?NkRaY0xtbHU2OHFTMVhRMjZ5aXVHcW5ZZHBqcWE0dFJYWW8vSkZCQzRFbzZN?=
 =?utf-8?B?RGQ1dTUxMDJxdFRHQTl5MkVUd3c5Y1YrenVtKzg5bUIwRFExa0RvR3phcFZI?=
 =?utf-8?B?SmtCTUhtQm9USTNhMXl1VGNjVFY5UExtK1ptL3hUbVdNcForNVB2Rmd1dU9D?=
 =?utf-8?B?U3FXalF0d2k4eUxlWFIrQkxUaGVML2dSY2F6WncrMDBBTVI3elNvK2VvclJh?=
 =?utf-8?B?THNsaXhkRXhXTkphcEFBMTgvZ1EwbWhYRDh0NWViRGdINExkSzV0eUpkSjBV?=
 =?utf-8?B?VndnekJrRVRoSTdXNHpJMTZIRmwwSVhBZjNSUlZpYkpVSCt2T3V4M2xKVjU2?=
 =?utf-8?Q?x5lIOXb5v0s=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA3PR11MB8118.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?U2RKcVQrRGgxNUt0WGhUbnpOMC90TUg5VklxMkt2djFjeHNGMXRmOHVBYUZ6?=
 =?utf-8?B?cjhhVjNkYm9NdzJQeVVubEVmaURHem1qbzlhcHRjM0dnSmRyN3M5UHovTmlO?=
 =?utf-8?B?aENzNDNwQXdtL1RhNUpMWmVxeCtlOU1kUy81MFUrSDlvdHFDeXBwY2l4dE8x?=
 =?utf-8?B?VU5sTkxYdEliTC9VVFlaaTR0eGZnZVlWS1dZNnBZTk1wQ3UrY0JUQ3dHRTFj?=
 =?utf-8?B?Q2J1ZDU2eWpZcnVINUJDK095ejZaRlcrOTIzZHRZdmY4SVp6UjFuaUVMZ2Z2?=
 =?utf-8?B?Z203ZWJtWVpDbjh6aE1qdlVuRitBZTYzc2xtUHpOTVZjOCtUZDZ4V2FUd2RI?=
 =?utf-8?B?RTFsbk85cVYwaVJqeU8yQldRS09MT3Yya2FmV0tQU3VSaXp3VG5BY3JuSUVF?=
 =?utf-8?B?eEtaN0haY09iVzJ0dlBza2pUcVRoemJ6YnpLT3JKb1F2ZHhBSDJVMm8yR0ZR?=
 =?utf-8?B?UXY4aGN0aXR0NEw1Sy85bjd4ZitURytabkV1THdLNm5RVEFwdkhkSk9yZitN?=
 =?utf-8?B?Q3hGZjRXZnlvdHdGVEZ2Qm5KaWQ4WitvZzI1Q3Ywd3Z3Mlo5QXp6YVRJb0VC?=
 =?utf-8?B?cGpnSk1wZEcyT0tzbjdXbWIwSllBb1hBMGRvY28ySmpucXFTOVhueFB3ZFRD?=
 =?utf-8?B?dWxHVkpBdEZyYVhwNlJDRFMzYzlPNmRSTEtwQmMrUi9wWW40YnhnbWs3dzdI?=
 =?utf-8?B?MlBucHlmM2FZSmdDTGpMdFJOR2NFTlowbjBYNjl4UzR6Zm1pYi9KZEJVM3ps?=
 =?utf-8?B?OHcwQ1pjRnNYZVpqbkUyZGN4T2ZUYlRPMmpHU0J3UXlqZXExcTBEQmZ3N0xa?=
 =?utf-8?B?Z1NzSDN4TTdUaVh5N20veXorWmJIT05BdU5uRjU4NjZIYnVoSDlSMzV2Y0ZT?=
 =?utf-8?B?OTlocGNpanJHWFk1WXVIOE9NNHBCSERjOFZpZEthQVBNL2V2c1YvSWt3Yzk4?=
 =?utf-8?B?VG1LTUxqNys5cjlHbGV1ck9OZDZCMndHWTlweDBwSHRSMWduUENCOTIwY2RX?=
 =?utf-8?B?UWVtN292dndXNnpITnlBWTRGSTUwR0JKVGlpcEliTUwrT3F2bG5YaHVpc0dU?=
 =?utf-8?B?UkV1azVoL09ZVzZkQlNJMllFZUxweUFNb0FoYWNQUFNvQ1E4eGdNd0dJUHl5?=
 =?utf-8?B?Qm1SbTBSakg5R2tqS2xXZ1BtRnNwMFNiQmJ2NGdqRk1nVEhoMTUwZW0wVFMw?=
 =?utf-8?B?VUo4bm4vcE9IdHBQUXhPUm5QZmk0RXpUVllZZ3BhdWI5SzdhdjRCZzR4NVp0?=
 =?utf-8?B?OTJoWTVXVDBvOENuM0JKYThING5Zd0p4M1ZIOE5VbWV2VkdMZkVrak1KaUZP?=
 =?utf-8?B?NHVRREE3WmlIRU13T09WemJ4ZU1JenJSZkNVb3l2dFpJWVpTSFQzdmkxSHBs?=
 =?utf-8?B?U0NMckZLL3VNSWIxNGYxRWw4c056N242bUhieGVMdmRlZUMrZS80THR4aTFj?=
 =?utf-8?B?RHZpejRnT3JBRUoyOTRlZGx2eGZHVnU2MTdXK09BTUtxeWF5NEs1WmVLRUNk?=
 =?utf-8?B?ZHUrL3Q4MWYrTURxNG1LVkFMcUpIbEFNMVJiMzNFSGMvQXBVK1k0L0pvMUk5?=
 =?utf-8?B?MUFOVDRVK3g3SzZGQyttbmtHRW1Wb2xNelUwQlc4L3VMcW9tRHJ5U25zenFP?=
 =?utf-8?B?T0FiNWN1QjlDSVgxMEFBZ2ErL2ZtMk50SEJDVFNYSk1tb1Ztdjlyc2hQeE5s?=
 =?utf-8?B?aGNveC93TWJHK0xhS0tYbXp3Wm5JTVhJcUczanpBdXVuWmxYZ2NJRGVMUVpR?=
 =?utf-8?B?N2lIL2QvRUVDTTN5d0d2b2U1UXF1RUE5ZUIxOUxFblQvQnNoWHUwZm5KNG0v?=
 =?utf-8?B?TzFHNWJpS3ZyOTVQUVZqM09PbmZkdTFoWDhCaXdRcU1aMmp2aGR1VktHZlRU?=
 =?utf-8?B?emdHNlFiNk42a2ZocUFBeHh6RGUxK2ZLRkVDTHRONmd2MHhoSHNsNENmZUVW?=
 =?utf-8?B?T2wzbnA2Z3o4d0sySmYxWFI2Nm1RV2hZc1FlOW44SEx6L05ncEx1UWJ4bU9h?=
 =?utf-8?B?SzJLNWc2Y09mUzY4ejVpZ3pNa1JHZ0dCcG1jQWNZV2FXNVRyOFU0NkZ4NEs3?=
 =?utf-8?B?M21TK2RwREUyN1NlQkhLaGEzLzg2WHp1Rm1CMkMyRVM3Z1pGbWtHYXBQNVhT?=
 =?utf-8?B?R3JBQVQxZ1o5allRRDhrSU9LWVpXWkI4SmtmVlgzWkxQZEg0bDI3N1AwazB0?=
 =?utf-8?B?SWc9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 0e21ac7e-6208-4a92-238f-08ddd46fa390
X-MS-Exchange-CrossTenant-AuthSource: SA3PR11MB8118.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Aug 2025 22:30:10.8799
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: rtNsa+4KkK+UrblnBhS83VzaFDlCVOoVSJNc3TufeAl3PX68XBaDUzgyppkqwjG9pWLyU6Z62Wv6jSj+rHikFyqVls306Z3zOrSEPulge/U=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH8PR11MB8061
X-OriginatorOrg: intel.com

Nikolay Borisov wrote:
> Since individual features are now locked down separately ensure that if
> the printing code is change to list them a buffer overrun won't be
> introduced.  As per Serge's recommendation switch from using sprintf to
> using snprintf and return EINVAL in case longer than 80 char string hasi
> to be printed.

I would have expected this safety to come before patch1, but it also
feels like the maximum buffer size could be calculated at compile time
to make the maximum output always fit.
