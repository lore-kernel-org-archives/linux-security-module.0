Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.21])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B5B6713B78F;
	Fri,  5 Jul 2024 06:30:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.21
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720161033; cv=fail; b=E6S48K5S41rxVIm1AgEBzZTKMYXKbQ8RNrjIJHezd9zMOpdLpJJ3ryDx4oM9M4lXnrKpVIdg9subzF7Xv6Z8t/dZx7RYNMZ5DegWDKQ50XrCa7OCL8x8i9o4lxMqe36+WWJG8s47BBrBvuddQsMNpwXX6mKmWTtbpiAQXSD7uJc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720161033; c=relaxed/simple;
	bh=U4jZnbPqz2XqnQybrIe5pH3b5ZCpH5Tu2oSxDNEQtyA=;
	h=Date:From:To:CC:Subject:Message-ID:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=d5CYGlTy2kELtVLKR5znFmZ8jGIJnU78iQ2HeVbvseMcaTiF26LUbKkybgVvy1rMOruzSZGVluQcxiGSw4DTc18jols53Q6ZhTPzM8mdnnO6pHE0hmOveSzd3c8UwfsVcyCArjJJaCGCb9sTr/dZFrJ9vmol/pR6mNU9hEAgLRw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Yu/bl45f; arc=fail smtp.client-ip=198.175.65.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Yu/bl45f"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1720161029; x=1751697029;
  h=date:from:to:cc:subject:message-id:
   content-transfer-encoding:in-reply-to:mime-version;
  bh=U4jZnbPqz2XqnQybrIe5pH3b5ZCpH5Tu2oSxDNEQtyA=;
  b=Yu/bl45fSwACGTXPAMEZfnAvjyygUgL04vlxH/W33LJd4BSPpC8Hyomr
   VMo4vXdDNNOuUCQXn/ZmS1yhHukyPh3+vIF2RvaNEnl3e7TbFwMYn9aAr
   cTycNNb0u9yT7XLhnmty6ON5KR3IPBMFgRZWce7bZVxIu842febrNymrg
   b1Hdn6Axryai84DCZG/M8Yso2NkXKB1v9KN4XuEadSxw9q3rmuZ0xyU38
   fC62H59GdTn7CqgCJNDE0W8MLVzP6MTj53wliv+Qq6oyb6srl4Sx60kJ+
   tcgfU4beaxP87vfns2laRSa59/NG43IO5FaE6Xnr6xBJQe6lYhdj8ORLt
   w==;
X-CSE-ConnectionGUID: beOOgpyHRUC+lMnFaKzL2A==
X-CSE-MsgGUID: 41HTnl+0QSapvbTV0HZ2rQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11123"; a="17395943"
X-IronPort-AV: E=Sophos;i="6.09,184,1716274800"; 
   d="scan'208";a="17395943"
Received: from orviesa004.jf.intel.com ([10.64.159.144])
  by orvoesa113.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Jul 2024 23:30:28 -0700
X-CSE-ConnectionGUID: Kn68YyZ4S2Ge9CiSV7psmg==
X-CSE-MsgGUID: h+cg+wKHRP+ObsCrU5g+mg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.09,184,1716274800"; 
   d="scan'208";a="51972520"
Received: from orsmsx603.amr.corp.intel.com ([10.22.229.16])
  by orviesa004.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 04 Jul 2024 23:30:29 -0700
Received: from orsmsx611.amr.corp.intel.com (10.22.229.24) by
 ORSMSX603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Thu, 4 Jul 2024 23:30:28 -0700
Received: from orsmsx611.amr.corp.intel.com (10.22.229.24) by
 ORSMSX611.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Thu, 4 Jul 2024 23:30:27 -0700
Received: from ORSEDG601.ED.cps.intel.com (10.7.248.6) by
 orsmsx611.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39 via Frontend Transport; Thu, 4 Jul 2024 23:30:27 -0700
Received: from NAM02-SN1-obe.outbound.protection.outlook.com (104.47.57.40) by
 edgegateway.intel.com (134.134.137.102) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Thu, 4 Jul 2024 23:30:27 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=nksGPY1Z8PBWOL2t/nribxSEiYXrCyOl1GBnFCUBiuxdRXPiFwse4NZU8P+XkLXvvxxxO5d8Y89LtYdn1pW/YnrNZSc+YU85FZr9JBnamvthdpCA+j+kN5fLD1jn3ubuGn/hX7pYoA9+Z5bX73RZv3j3cddmsv2PBrxdoD9hGIgSibe/ON4CMCUqIqspiF59eobjFSLWamqT9XAAWLZaGlZGAD7K+NaCmVmILPHqOux+y3s8GVUjj6lWk/A/cfg7WjoAoJYtXUlLRYRGn+JGIeoyJI0VwZwTvOUyUIjHUUZC9/EgNApiPI6oR/kaqOB61vekF+s68aCs2VtPBpfnLQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=yK8f7q5EolwM3io3phxvOR95qLggpgLfggyvFOiiob8=;
 b=W7Y+eOYJ3r0B8v7Z0DKAUXa6w0Rx1Fc3YS/ZY4I3rD8iPv2jwrxrjdOI5oT1gyM4OuWvWYwWjIsQAnQPobQS42wYRzVtjKGO6DqPc+6xBsXeZkSUd2tjb8l7gDyk79op+iPIgkuufB/oMRRTDeCYslxJHJQYbAqATgRV5ckBSRQGyZzQa9TxeunxOcNjqlHrVxKBAAdyVuBZEJw4Cmq1g3baxP1yR3VfWd9OSb05gfuZrhnG5ilkM45w2L4++2mO0liZ7zy7HrKo4NnS5u01kiYfUTROAWTchtLuXivZtgePlflBMv5gxMS8CSzcAaq1PVk5G+GOro50KPiinpmsRA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from LV3PR11MB8603.namprd11.prod.outlook.com (2603:10b6:408:1b6::9)
 by CH0PR11MB5267.namprd11.prod.outlook.com (2603:10b6:610:e2::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7741.29; Fri, 5 Jul
 2024 06:30:19 +0000
Received: from LV3PR11MB8603.namprd11.prod.outlook.com
 ([fe80::4622:29cf:32b:7e5c]) by LV3PR11MB8603.namprd11.prod.outlook.com
 ([fe80::4622:29cf:32b:7e5c%4]) with mapi id 15.20.7741.025; Fri, 5 Jul 2024
 06:30:19 +0000
Date: Fri, 5 Jul 2024 14:30:06 +0800
From: kernel test robot <oliver.sang@intel.com>
To: Mateusz Guzik <mjguzik@gmail.com>
CC: <oe-lkp@lists.linux.dev>, <lkp@intel.com>, <apparmor@lists.ubuntu.com>,
	<ying.huang@intel.com>, <feng.tang@intel.com>, <fengwei.yin@intel.com>,
	<john.johansen@canonical.com>, <paul@paul-moore.com>, <jmorris@namei.org>,
	<serge@hallyn.com>, <linux-kernel@vger.kernel.org>,
	<linux-security-module@vger.kernel.org>, <Neeraj.Upadhyay@amd.com>, "Mateusz
 Guzik" <mjguzik@gmail.com>, <oliver.sang@intel.com>
Subject: Re: [PATCH v2] apparmor: try to avoid refing the label in
 apparmor_file_open
Message-ID: <202407051440.a54b7d0f-oliver.sang@intel.com>
Content-Type: text/plain; charset="iso-8859-1"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20240620171528.167997-1-mjguzik@gmail.com>
X-ClientProxiedBy: SG2PR01CA0123.apcprd01.prod.exchangelabs.com
 (2603:1096:4:40::27) To LV3PR11MB8603.namprd11.prod.outlook.com
 (2603:10b6:408:1b6::9)
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV3PR11MB8603:EE_|CH0PR11MB5267:EE_
X-MS-Office365-Filtering-Correlation-Id: 24af641c-0d02-4696-1c91-08dc9cbbf07b
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|7416014|1800799024|366016;
X-Microsoft-Antispam-Message-Info: =?iso-8859-1?Q?7LdEPtA9ZwTd+xjujKGsCzBKML16/KLIo/ja/smKiNKL+0oy2tFMqgurt2?=
 =?iso-8859-1?Q?+P1FQvnHyTurZf2FdoLsucWl8g7i09Yhy3FWlon2gKrolmiQpFQ8U7rOE9?=
 =?iso-8859-1?Q?iNpzthgBWdqdBfrIHxm0j8NLm0VcKH+NwP+RinG7WcJDChrdgBaJqlCaUl?=
 =?iso-8859-1?Q?0LCIATylxPEQMCCsZJMZ6GVLsWyvTG68eyGQoSGkuA3glP8DPiD/9pN9+H?=
 =?iso-8859-1?Q?BFTvpSlzoOuw2VTW01L5ZJrDeJCuYKd1Ey9qwy++LKRQwkCIaX5xGzP4+P?=
 =?iso-8859-1?Q?DZiQIwvSiajbo3LhqY/Cnf9+nxmgt+cIa0gb1pzBaDB+bDHJlw3rH7TRlm?=
 =?iso-8859-1?Q?YF989f6Ze6gxuoL88QtlKK0x/5Pw+dNYF6YFq1iaD4IqBZIrBGYSybCc9d?=
 =?iso-8859-1?Q?eQPHWJ2X1NnfMs38XqLUBtteemE71IWCxv7PC5P9dtM78Lwb6DMCRg4bVx?=
 =?iso-8859-1?Q?LbF2Nt3HBPptvmjfWJ4BOfi8jnmLKPw7rHDGwylaNZboWiPhj0Q39pUMnq?=
 =?iso-8859-1?Q?a1V0UKXyIAaDkqvFRfwMzlnDzOUsc1AC+H6AlNOm0FG6vrdUqpd+tXif5D?=
 =?iso-8859-1?Q?3RF/zBw8/MpFGj/1AabQLhfLWx2LgUF8cIhVhI19Zmh9+A5NrQgAQWZdAm?=
 =?iso-8859-1?Q?5eOj0KW5FpGobF/Ylvf2FvKHyVkJfr56CMqgVyvdbu1gZYHGQOUHdPM/Lf?=
 =?iso-8859-1?Q?SlGt0m0JlbTIDE8Y0Ew/nJII2RlrYLu5W4x471DdKdNrZh7oL+ekBpEH/N?=
 =?iso-8859-1?Q?RoyW7trtTGEGYeCm2Za5JPt6IpY7V41b/OpAxsFUjS9cJjueRop6mJRYKT?=
 =?iso-8859-1?Q?NXxANOfHCDPdzAN6QUEkD54mzCCyJ14h1O7K1HHAyTGs6picTPp/tt0/Nn?=
 =?iso-8859-1?Q?7NbuUyxCP99IX5aRI6MN65oDwwxKeqpviWrH170RT9FWWlairrQT/ScfTU?=
 =?iso-8859-1?Q?gTU9+3UjMOFWrbR6KeUROPBlyNrKJ0/nGaA/5Bp+qmEocG53qaZeb904xE?=
 =?iso-8859-1?Q?Fm0rWZTW/MBg3P9qPHokO552SWm5u/3js3FMS7J43499H5hnzFz5cRT5wB?=
 =?iso-8859-1?Q?hgsYR1h+MhGhKvrAZRYzjl7se9nfpbQsMk5m1oeR0RJAI6sGsqunzj0t5c?=
 =?iso-8859-1?Q?KwKyj48rkqobbsGavITLJD7t2uwV+TOObgivpw7Pu1cUUlyZ1gZ+Na9q7r?=
 =?iso-8859-1?Q?BQruUo7o5GhsbqnDQ+r9GEjP3zU+MtiZ+FbxAd3VXnBmOizY+WUzOqpuiN?=
 =?iso-8859-1?Q?o/vPMormYp8EjSWRzp3c539JY6PbSdRWS+mbvAR5/Jc296fJpzqHJIgjPR?=
 =?iso-8859-1?Q?fVyTy+xQooOMpevpZh9tvI+7fuyY92HY74vjpkQ/Ql8/rCh1fNX1sC3m+I?=
 =?iso-8859-1?Q?QIlrN/Yjq/?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV3PR11MB8603.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(1800799024)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?iso-8859-1?Q?uemsNEYcCcKAv7vowGaF6vvNUqEF/2xtF17X8qvLdfgdr0+RJtLu7PLFLV?=
 =?iso-8859-1?Q?JUEt9CmXH3WISkuBnMLoc5TdCJlYdkCkwcyMaHfb9U6IXPBKukdEX9kfNj?=
 =?iso-8859-1?Q?uf7V7HjCMWUIJNwg1sU3NYC9l55wPBadbGVFdHoBBMIYoEjcYTPjhSRLwv?=
 =?iso-8859-1?Q?uMMHjfxwzVILsKdB14BoEmHXX0i2OMJsCx9sF1v9JLS40IYxCbtyxqFtyC?=
 =?iso-8859-1?Q?XhDPTwgVs6v1jbJkIRCyCZVVgUHh4pzC0Fr2rsNNPmkpK799zeu9GAOlAr?=
 =?iso-8859-1?Q?N7AOzC29FWMkFKFXzl1rsPflxYjefLR4WuvC0B9TVuCoSZ4KJaRCC5bM/h?=
 =?iso-8859-1?Q?s2B1lB9LewqbtOUWhtbmh+QtwADXZrsX/C8XLX5D9H6qQMpZji4drhS0E7?=
 =?iso-8859-1?Q?+0iM4aKw4/vGG72gqVdEX8tPnEnk8BFhjhLDb+3HFVLCkPZivGimD1dSCG?=
 =?iso-8859-1?Q?Qwz+5jT74HXnRcuwbewi4s4hYrSzpdhGFDbCCtGFt0OO/u4gG5OsNVatN/?=
 =?iso-8859-1?Q?dC5FZgoy/AQCJGJYTvSCLgR1TIA1D/cRi6ePmuUIscipUgyx+C+0Yp5Cum?=
 =?iso-8859-1?Q?T5Z9o/WpxcMK1KYIHilHK6mlRXHTm0cwaRpgiQzI+p6cRu3o4dVZ1DCCIg?=
 =?iso-8859-1?Q?uVtynz+ZZx889CMHFFHhzYJ6v8G0xox6vfJzOpm/p9KJVni46s6liuunlw?=
 =?iso-8859-1?Q?vs+1vVIa7vyiReHLX/NX6TS60zHvEzuAVavHSlzPv4kpTYNSOpflINd5Z7?=
 =?iso-8859-1?Q?zpUNLD4n9tFTGEMn2XTsYWOtbnMD03YEv4SIbrgNl9YOIMTu2oe64soSvv?=
 =?iso-8859-1?Q?dTshD1miefTzww8X/cYlHqLPHjOaAwrEfZxht4FrsKg2QN6emFxJOa5TbG?=
 =?iso-8859-1?Q?zZ/YoTErWQvCm8+cvS05DNjdVU9xlyGUkkGTBN+7AX3VR+C/dUz+M0j3+C?=
 =?iso-8859-1?Q?WGD+twJwXIdx1xh9IQlv24cyQt639JMTwd/HqujdAQq1THKy8G+Jedlyvl?=
 =?iso-8859-1?Q?c/gTCVZzh0vzrO6erOTHyKgdHO7d3YSQWJ4TkuFme4r1Jtjz0lv/A+hHGq?=
 =?iso-8859-1?Q?8reBhlkmU2nsnNxhWR+PEqMXAENRS9/gZKbe1dZZt39siRu2mJg+4A/Y0H?=
 =?iso-8859-1?Q?5kXI/jYZduj/G1e0jp7imDaUtWPbMiUYAzgUdMz0f7dvl1P66h2oUxswyo?=
 =?iso-8859-1?Q?yNMNmGTJn6NjjXq/M8fFcrS4ml6vh1J4tc/z+iyZHegk3suebHegCtzgz/?=
 =?iso-8859-1?Q?lJEMxJPIRocHWferw4j9IUxpQZ3GwdW186s7zhODX/zR7mk/xTVaL+pXPp?=
 =?iso-8859-1?Q?b6h7FypKk4Nh20yOmMKPzreabzfhK5OyIcwM2kIDwrVhnhIqK+8Ej0yAkh?=
 =?iso-8859-1?Q?H+lrR4wCm3i0vCdzltqF4fiC8Q/eYJOD46sMizdiyrUVCcphwMYPu/XoQq?=
 =?iso-8859-1?Q?jDtS7AYfAysuNWYFoeL5lpESkej1xgOk7u7QTdUY7HNwb/J3NhkyCNhnbh?=
 =?iso-8859-1?Q?9l1Uw7J9ofoAwJanECoVwLrOYOGDNF4q9r3DDoWuObM605Gz36IgA6ez7z?=
 =?iso-8859-1?Q?K1ff30F/mEVuzjAmkJgPMYOPMO2JAHd8kzmWu8zZrO6HHLpUCLwZeYzcAy?=
 =?iso-8859-1?Q?5T4Bii0qA2JhzXQd4PMALqTlbCxDPCd5gZmiZAwUCmni9RBjh6IA5cNw?=
 =?iso-8859-1?Q?=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 24af641c-0d02-4696-1c91-08dc9cbbf07b
X-MS-Exchange-CrossTenant-AuthSource: LV3PR11MB8603.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Jul 2024 06:30:19.1391
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: lotipDdwRNSD0LcnKWKtl9eVTW7I/uiuLt3t3jIZXNpXeEM1szSt6CsGqOM/Hk2DKOq+lZ5cy57GIVjJfSlPiw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH0PR11MB5267
X-OriginatorOrg: intel.com



Hello,

kernel test robot noticed a 93.1% improvement of will-it-scale.per_process_ops on:


commit: 22eddbc906d2fc507e4a01484e2985fdd6f3cb2f ("[PATCH v2] apparmor: try to avoid refing the label in apparmor_file_open")
url: https://github.com/intel-lab-lkp/linux/commits/Mateusz-Guzik/apparmor-try-to-avoid-refing-the-label-in-apparmor_file_open/20240625-143723
base: https://git.kernel.org/cgit/linux/kernel/git/torvalds/linux.git 55027e689933ba2e64f3d245fb1ff185b3e7fc81
patch link: https://lore.kernel.org/all/20240620171528.167997-1-mjguzik@gmail.com/
patch subject: [PATCH v2] apparmor: try to avoid refing the label in apparmor_file_open

testcase: will-it-scale
test machine: 104 threads 2 sockets (Skylake) with 192G memory
parameters:

	nr_task: 100%
	mode: process
	test: open2
	cpufreq_governor: performance


In addition to that, the commit also has significant impact on the following tests:

+------------------+----------------------------------------------------------------+
| testcase: change | will-it-scale: will-it-scale.per_process_ops 90.7% improvement |
| test machine     | 104 threads 2 sockets (Skylake) with 192G memory               |
| test parameters  | cpufreq_governor=performance                                   |
|                  | mode=process                                                   |
|                  | nr_task=100%                                                   |
|                  | test=open1                                                     |
+------------------+----------------------------------------------------------------+




Details are as below:
-------------------------------------------------------------------------------------------------->


The kernel config and materials to reproduce are available at:
https://download.01.org/0day-ci/archive/20240705/202407051440.a54b7d0f-oliver.sang@intel.com

=========================================================================================
compiler/cpufreq_governor/kconfig/mode/nr_task/rootfs/tbox_group/test/testcase:
  gcc-13/performance/x86_64-rhel-8.3/process/100%/debian-12-x86_64-20240206.cgz/lkp-skl-fpga01/open2/will-it-scale

commit: 
  55027e6899 ("Merge tag 'input-for-v6.10-rc5' of git://git.kernel.org/pub/scm/linux/kernel/git/dtor/input")
  22eddbc906 ("apparmor: try to avoid refing the label in apparmor_file_open")

55027e689933ba2e 22eddbc906d2fc507e4a01484e2 
---------------- --------------------------- 
         %stddev     %change         %stddev
             \          |                \  
      4985 ±  4%     -11.4%       4415 ±  5%  perf-c2c.HITM.local
      1788            -3.3%       1729        vmstat.system.cs
      0.01 ±  2%      -0.0        0.01        mpstat.cpu.all.soft%
     19.61            +3.2       22.81 ±  3%  mpstat.cpu.all.usr%
     12729 ±  3%      -8.1%      11703        proc-vmstat.nr_mapped
     50690 ±  7%     +52.4%      77253 ± 13%  proc-vmstat.pgactivate
    967492            +2.0%     986437        proc-vmstat.pgfault
   4175664           +93.1%    8063854 ±  2%  will-it-scale.104.processes
     40150           +93.1%      77536 ±  2%  will-it-scale.per_process_ops
   4175664           +93.1%    8063854 ±  2%  will-it-scale.workload
    649.36 ± 12%     +19.5%     776.11 ±  4%  sched_debug.cfs_rq:/.util_avg.min
     79.88 ± 16%     -25.0%      59.92 ±  4%  sched_debug.cfs_rq:/.util_avg.stddev
     25.33 ±  8%     -51.6%      12.26 ±  9%  sched_debug.cpu.clock.stddev
      2791 ±  4%     -13.1%       2425 ±  8%  sched_debug.cpu.curr->pid.min
      2958 ±  5%      +9.9%       3251 ±  4%  sched_debug.cpu.nr_switches.stddev
 4.716e+09           +86.3%  8.787e+09 ±  4%  perf-stat.i.branch-instructions
      1.09            -0.1        0.98 ±  6%  perf-stat.i.branch-miss-rate%
  51277236 ±  2%     +60.0%   82061991 ±  4%  perf-stat.i.branch-misses
      1741            -2.8%       1692        perf-stat.i.context-switches
     11.66           -47.6%       6.11        perf-stat.i.cpi
    145.32           +11.1%     161.46        perf-stat.i.cpu-migrations
 2.479e+10           +86.9%  4.634e+10 ±  4%  perf-stat.i.instructions
      0.09 ±  2%     +89.9%       0.17        perf-stat.i.ipc
      1.09 ±  2%      -0.2        0.93        perf-stat.overall.branch-miss-rate%
     11.67           -47.1%       6.17 ±  2%  perf-stat.overall.cpi
      0.09           +89.2%       0.16 ±  2%  perf-stat.overall.ipc
   1790350            -1.8%    1758176        perf-stat.overall.path-length
   4.7e+09           +86.3%  8.758e+09 ±  4%  perf-stat.ps.branch-instructions
  51036303 ±  2%     +60.2%   81758969 ±  4%  perf-stat.ps.branch-misses
      1734            -2.8%       1685        perf-stat.ps.context-switches
    144.39           +11.4%     160.88        perf-stat.ps.cpu-migrations
 2.471e+10           +87.0%   4.62e+10 ±  4%  perf-stat.ps.instructions
 7.476e+12           +89.7%  1.418e+13 ±  2%  perf-stat.total.instructions
     27.64           -22.1        5.54 ±  7%  perf-profile.calltrace.cycles-pp.security_file_open.do_dentry_open.do_open.path_openat.do_filp_open
     27.59           -22.1        5.50 ±  7%  perf-profile.calltrace.cycles-pp.apparmor_file_open.security_file_open.do_dentry_open.do_open.path_openat
     29.20           -21.6        7.60 ±  3%  perf-profile.calltrace.cycles-pp.do_dentry_open.do_open.path_openat.do_filp_open.do_sys_openat2
     34.98           -19.0       16.00 ±  4%  perf-profile.calltrace.cycles-pp.do_open.path_openat.do_filp_open.do_sys_openat2.__x64_sys_openat
     58.91           -10.1       48.79        perf-profile.calltrace.cycles-pp.do_sys_openat2.__x64_sys_openat.do_syscall_64.entry_SYSCALL_64_after_hwframe.open64
     58.99           -10.0       48.95        perf-profile.calltrace.cycles-pp.__x64_sys_openat.do_syscall_64.entry_SYSCALL_64_after_hwframe.open64
     59.31            -9.9       49.38        perf-profile.calltrace.cycles-pp.do_syscall_64.entry_SYSCALL_64_after_hwframe.open64
     60.42            -9.3       51.07        perf-profile.calltrace.cycles-pp.entry_SYSCALL_64_after_hwframe.open64
     53.49            -8.3       45.16        perf-profile.calltrace.cycles-pp.path_openat.do_filp_open.do_sys_openat2.__x64_sys_openat.do_syscall_64
     53.68            -8.2       45.50        perf-profile.calltrace.cycles-pp.do_filp_open.do_sys_openat2.__x64_sys_openat.do_syscall_64.entry_SYSCALL_64_after_hwframe
     73.99            -8.1       65.90        perf-profile.calltrace.cycles-pp.open64
      3.15 ±  4%      -2.5        0.63 ± 16%  perf-profile.calltrace.cycles-pp.putname.do_sys_openat2.__x64_sys_openat.do_syscall_64.entry_SYSCALL_64_after_hwframe
      3.90            +0.1        4.03 ±  2%  perf-profile.calltrace.cycles-pp.entry_SYSRETQ_unsafe_stack.__close
      0.52            +0.4        0.94 ±  3%  perf-profile.calltrace.cycles-pp.kmem_cache_alloc_noprof.alloc_empty_file.path_openat.do_filp_open.do_sys_openat2
      0.65            +0.5        1.10 ±  2%  perf-profile.calltrace.cycles-pp.strncpy_from_user.getname_flags.do_sys_openat2.__x64_sys_openat.do_syscall_64
      3.34 ±  3%      +0.6        3.90        perf-profile.calltrace.cycles-pp.syscall_return_via_sysret.open64
      0.87            +0.6        1.51 ±  2%  perf-profile.calltrace.cycles-pp.getname_flags.do_sys_openat2.__x64_sys_openat.do_syscall_64.entry_SYSCALL_64_after_hwframe
      7.82            +0.8        8.60 ±  3%  perf-profile.calltrace.cycles-pp.entry_SYSRETQ_unsafe_stack.open64
      0.00            +0.8        0.78 ±  2%  perf-profile.calltrace.cycles-pp.__check_object_size.strncpy_from_user.getname_flags.do_sys_openat2.__x64_sys_openat
      0.00            +0.8        0.80 ±  3%  perf-profile.calltrace.cycles-pp.entry_SYSCALL_64.open64
      0.00            +0.8        0.83 ±  3%  perf-profile.calltrace.cycles-pp.entry_SYSCALL_64.__close
      1.48            +0.9        2.40 ±  3%  perf-profile.calltrace.cycles-pp.link_path_walk.path_openat.do_filp_open.do_sys_openat2.__x64_sys_openat
      2.19 ±  2%      +1.3        3.54        perf-profile.calltrace.cycles-pp.syscall_return_via_sysret.__close
      3.28 ±  5%      +2.7        5.95 ±  6%  perf-profile.calltrace.cycles-pp.apparmor_current_getsecid_subj.security_current_getsecid_subj.ima_file_check.security_file_post_open.do_open
      3.31 ±  5%      +2.7        6.00 ±  6%  perf-profile.calltrace.cycles-pp.security_current_getsecid_subj.ima_file_check.security_file_post_open.do_open.path_openat
      3.62 ±  4%      +2.8        6.40 ±  5%  perf-profile.calltrace.cycles-pp.ima_file_check.security_file_post_open.do_open.path_openat.do_filp_open
      3.66 ±  4%      +2.8        6.44 ±  5%  perf-profile.calltrace.cycles-pp.security_file_post_open.do_open.path_openat.do_filp_open.do_sys_openat2
     12.01            +4.9       16.88 ±  2%  perf-profile.calltrace.cycles-pp.apparmor_file_free_security.security_file_free.__fput.__x64_sys_close.do_syscall_64
     12.04            +4.9       16.94 ±  2%  perf-profile.calltrace.cycles-pp.security_file_free.__fput.__x64_sys_close.do_syscall_64.entry_SYSCALL_64_after_hwframe
     14.50            +5.8       20.27        perf-profile.calltrace.cycles-pp.__fput.__x64_sys_close.do_syscall_64.entry_SYSCALL_64_after_hwframe.__close
     17.92            +6.1       23.98        perf-profile.calltrace.cycles-pp.entry_SYSCALL_64_after_hwframe.__close
     16.03            +6.2       22.19        perf-profile.calltrace.cycles-pp.do_syscall_64.entry_SYSCALL_64_after_hwframe.__close
     15.50            +6.2       21.72        perf-profile.calltrace.cycles-pp.__x64_sys_close.do_syscall_64.entry_SYSCALL_64_after_hwframe.__close
     25.29            +8.2       33.52        perf-profile.calltrace.cycles-pp.__close
     15.10            +8.9       23.97        perf-profile.calltrace.cycles-pp.init_file.alloc_empty_file.path_openat.do_filp_open.do_sys_openat2
     14.08            +9.2       23.29        perf-profile.calltrace.cycles-pp.apparmor_file_alloc_security.security_file_alloc.init_file.alloc_empty_file.path_openat
     14.36            +9.4       23.73        perf-profile.calltrace.cycles-pp.security_file_alloc.init_file.alloc_empty_file.path_openat.do_filp_open
     15.80            +9.4       25.18        perf-profile.calltrace.cycles-pp.alloc_empty_file.path_openat.do_filp_open.do_sys_openat2.__x64_sys_openat
     27.62           -22.1        5.50 ±  7%  perf-profile.children.cycles-pp.apparmor_file_open
     27.64           -22.1        5.55 ±  7%  perf-profile.children.cycles-pp.security_file_open
     29.21           -21.6        7.62 ±  3%  perf-profile.children.cycles-pp.do_dentry_open
     35.00           -19.0       16.04 ±  4%  perf-profile.children.cycles-pp.do_open
     58.96           -10.1       48.86        perf-profile.children.cycles-pp.do_sys_openat2
     59.02           -10.0       48.97        perf-profile.children.cycles-pp.__x64_sys_openat
     53.54            -8.3       45.22        perf-profile.children.cycles-pp.path_openat
     53.70            -8.2       45.53        perf-profile.children.cycles-pp.do_filp_open
     73.60            -7.6       66.03        perf-profile.children.cycles-pp.open64
     75.93            -4.2       71.78        perf-profile.children.cycles-pp.do_syscall_64
     79.03            -3.7       75.32        perf-profile.children.cycles-pp.entry_SYSCALL_64_after_hwframe
      3.15 ±  4%      -2.5        0.63 ± 16%  perf-profile.children.cycles-pp.putname
      0.80 ± 10%      -0.6        0.16 ±  7%  perf-profile.children.cycles-pp.lockref_get_not_dead
      0.86 ±  9%      -0.6        0.22 ±107%  perf-profile.children.cycles-pp.__cmd_record
      0.86 ±  9%      -0.6        0.22 ±107%  perf-profile.children.cycles-pp.cmd_record
      0.86 ±  9%      -0.6        0.22 ±108%  perf-profile.children.cycles-pp.record__mmap_read_evlist
      0.87 ±  9%      -0.6        0.23 ±104%  perf-profile.children.cycles-pp.main
      0.87 ±  9%      -0.6        0.23 ±104%  perf-profile.children.cycles-pp.run_builtin
      0.84 ±  9%      -0.6        0.21 ±109%  perf-profile.children.cycles-pp.perf_mmap__push
      0.82 ±  8%      -0.6        0.20 ±106%  perf-profile.children.cycles-pp.write
      0.81 ±  9%      -0.6        0.20 ±110%  perf-profile.children.cycles-pp.writen
      0.80 ±  9%      -0.6        0.20 ±110%  perf-profile.children.cycles-pp.record__pushfn
      0.48 ±  8%      -0.4        0.12 ± 99%  perf-profile.children.cycles-pp.ksys_write
      0.42 ±  9%      -0.3        0.11 ±109%  perf-profile.children.cycles-pp.vfs_write
      0.41 ±  9%      -0.3        0.14 ±  6%  perf-profile.children.cycles-pp.mnt_get_write_access
      0.96 ±  5%      -0.1        0.84 ±  6%  perf-profile.children.cycles-pp.lockref_put_return
      0.61 ±  3%      -0.1        0.52 ±  4%  perf-profile.children.cycles-pp.entry_SYSCALL_64_safe_stack
      0.27 ±  6%      -0.1        0.21 ± 10%  perf-profile.children.cycles-pp.__fput_sync
      0.29 ±  9%      -0.1        0.24 ±  2%  perf-profile.children.cycles-pp._raw_spin_lock
      0.10 ±  6%      -0.0        0.08 ±  7%  perf-profile.children.cycles-pp.lockref_get
      0.06 ±  9%      +0.0        0.08 ±  6%  perf-profile.children.cycles-pp.make_vfsuid
      0.24 ±  6%      +0.0        0.27 ±  2%  perf-profile.children.cycles-pp.process_measurement
      0.13 ±  5%      +0.0        0.16 ±  4%  perf-profile.children.cycles-pp.fd_install
      0.08 ±  4%      +0.0        0.11 ±  4%  perf-profile.children.cycles-pp.ima_file_free
      0.08 ±  5%      +0.0        0.13 ±  2%  perf-profile.children.cycles-pp.security_inode_permission
      0.07 ±  6%      +0.0        0.12 ±  7%  perf-profile.children.cycles-pp.set_root
      0.07 ± 10%      +0.0        0.12 ±  6%  perf-profile.children.cycles-pp.syscall_exit_to_user_mode_prepare
      0.00            +0.1        0.05 ±  7%  perf-profile.children.cycles-pp._find_next_zero_bit
      0.00            +0.1        0.05 ±  7%  perf-profile.children.cycles-pp.dnotify_flush
      0.00            +0.1        0.05 ±  7%  perf-profile.children.cycles-pp.get_unused_fd_flags
      0.06 ± 11%      +0.1        0.12 ±  6%  perf-profile.children.cycles-pp.rcu_all_qs
      0.06            +0.1        0.11 ±  6%  perf-profile.children.cycles-pp.x64_sys_call
      0.00            +0.1        0.06 ±  9%  perf-profile.children.cycles-pp.locks_remove_file
      0.00            +0.1        0.06 ±  6%  perf-profile.children.cycles-pp.should_failslab
      0.12 ±  4%      +0.1        0.18 ±  2%  perf-profile.children.cycles-pp.evm_file_release
      0.10 ±  4%      +0.1        0.16 ±  4%  perf-profile.children.cycles-pp.nd_jump_root
      0.00            +0.1        0.06 ±  9%  perf-profile.children.cycles-pp.path_get
      0.07 ±  6%      +0.1        0.14 ±  9%  perf-profile.children.cycles-pp.obj_cgroup_charge
      0.02 ± 99%      +0.1        0.09 ± 10%  perf-profile.children.cycles-pp.file_close_fd_locked
      0.00            +0.1        0.06 ±  7%  perf-profile.children.cycles-pp.getname
      0.00            +0.1        0.07 ± 11%  perf-profile.children.cycles-pp.file_ra_state_init
      0.00            +0.1        0.07 ±  5%  perf-profile.children.cycles-pp.check_stack_object
      0.29 ±  6%      +0.1        0.36 ±  3%  perf-profile.children.cycles-pp.alloc_fd
      0.09 ±  7%      +0.1        0.16 ±  4%  perf-profile.children.cycles-pp.mntput_no_expire
      0.16 ±  7%      +0.1        0.23 ±  4%  perf-profile.children.cycles-pp.path_init
      0.00            +0.1        0.07 ±  8%  perf-profile.children.cycles-pp.refill_obj_stock
      0.20 ±  9%      +0.1        0.27 ±  3%  perf-profile.children.cycles-pp.file_close_fd
      0.10 ± 10%      +0.1        0.18 ±  5%  perf-profile.children.cycles-pp.__lookup_mnt
      0.09 ±  4%      +0.1        0.17 ±  4%  perf-profile.children.cycles-pp.mod_objcg_state
      0.39 ±  4%      +0.1        0.48 ±  2%  perf-profile.children.cycles-pp.__fsnotify_parent
      0.10 ±  4%      +0.1        0.19 ±  3%  perf-profile.children.cycles-pp.__check_heap_object
      0.10 ±  3%      +0.1        0.20 ±  3%  perf-profile.children.cycles-pp.locks_remove_posix
      0.22 ±  5%      +0.1        0.32 ±  2%  perf-profile.children.cycles-pp.syscall_exit_to_user_mode
      0.11 ±  3%      +0.1        0.21 ±  2%  perf-profile.children.cycles-pp.memset_orig
      0.08 ±  6%      +0.1        0.18 ±  3%  perf-profile.children.cycles-pp.build_open_flags
      0.14 ± 17%      +0.1        0.25 ±  9%  perf-profile.children.cycles-pp.testcase
      0.18 ±  2%      +0.1        0.30 ±  3%  perf-profile.children.cycles-pp.__virt_addr_valid
      0.16 ±  2%      +0.1        0.28 ±  2%  perf-profile.children.cycles-pp.__cond_resched
      0.40 ±  6%      +0.1        0.54 ±  4%  perf-profile.children.cycles-pp.may_open
      0.30            +0.2        0.44 ±  2%  perf-profile.children.cycles-pp.check_heap_object
      0.29            +0.2        0.44 ±  2%  perf-profile.children.cycles-pp.security_file_release
      0.17 ±  2%      +0.2        0.33 ±  4%  perf-profile.children.cycles-pp.filp_flush
      0.30 ±  5%      +0.2        0.46 ±  5%  perf-profile.children.cycles-pp.generic_permission
      0.22 ±  5%      +0.2        0.39 ±  6%  perf-profile.children.cycles-pp.__memcg_slab_free_hook
      0.35 ±  7%      +0.2        0.52 ±  4%  perf-profile.children.cycles-pp.__d_lookup_rcu
      0.25 ±  6%      +0.2        0.44 ±  5%  perf-profile.children.cycles-pp.open_last_lookups
      0.35 ±  5%      +0.2        0.55 ±  4%  perf-profile.children.cycles-pp.walk_component
      0.26 ±  2%      +0.2        0.48 ±  4%  perf-profile.children.cycles-pp.__memcg_slab_post_alloc_hook
      0.40 ±  6%      +0.2        0.63 ±  4%  perf-profile.children.cycles-pp.lookup_fast
      0.32 ±  3%      +0.2        0.55 ±  4%  perf-profile.children.cycles-pp.step_into
      0.64 ±  5%      +0.2        0.88 ±  4%  perf-profile.children.cycles-pp.inode_permission
      0.50            +0.3        0.82 ±  2%  perf-profile.children.cycles-pp.__check_object_size
     12.65            +0.4       13.04        perf-profile.children.cycles-pp.entry_SYSRETQ_unsafe_stack
      0.66            +0.5        1.12 ±  2%  perf-profile.children.cycles-pp.strncpy_from_user
      1.42 ±  2%      +0.6        2.01 ±  3%  perf-profile.children.cycles-pp.entry_SYSCALL_64
      0.87            +0.6        1.52 ±  2%  perf-profile.children.cycles-pp.getname_flags
      0.93 ±  2%      +0.7        1.64 ±  3%  perf-profile.children.cycles-pp.kmem_cache_alloc_noprof
      1.50            +0.9        2.42 ±  3%  perf-profile.children.cycles-pp.link_path_walk
      5.64 ±  2%      +1.9        7.57        perf-profile.children.cycles-pp.syscall_return_via_sysret
      3.29 ±  5%      +2.7        5.96 ±  6%  perf-profile.children.cycles-pp.apparmor_current_getsecid_subj
      3.31 ±  5%      +2.7        6.01 ±  6%  perf-profile.children.cycles-pp.security_current_getsecid_subj
      3.64 ±  4%      +2.8        6.41 ±  5%  perf-profile.children.cycles-pp.ima_file_check
      3.66 ±  4%      +2.8        6.44 ±  5%  perf-profile.children.cycles-pp.security_file_post_open
     12.02            +4.9       16.89 ±  2%  perf-profile.children.cycles-pp.apparmor_file_free_security
     12.06            +4.9       16.94 ±  2%  perf-profile.children.cycles-pp.security_file_free
     14.54            +5.8       20.33        perf-profile.children.cycles-pp.__fput
     15.51            +6.2       21.74        perf-profile.children.cycles-pp.__x64_sys_close
     25.38            +8.3       33.68        perf-profile.children.cycles-pp.__close
     15.14            +8.9       24.00        perf-profile.children.cycles-pp.init_file
     14.10            +9.2       23.31        perf-profile.children.cycles-pp.apparmor_file_alloc_security
     14.37            +9.4       23.74        perf-profile.children.cycles-pp.security_file_alloc
     15.82            +9.4       25.20        perf-profile.children.cycles-pp.alloc_empty_file
     27.52           -22.0        5.48 ±  7%  perf-profile.self.cycles-pp.apparmor_file_open
      3.14 ±  4%      -2.5        0.63 ± 16%  perf-profile.self.cycles-pp.putname
      0.80 ± 10%      -0.6        0.16 ±  8%  perf-profile.self.cycles-pp.lockref_get_not_dead
      0.76 ± 12%      -0.5        0.23 ± 30%  perf-profile.self.cycles-pp.init_file
      0.41 ±  8%      -0.3        0.14 ±  7%  perf-profile.self.cycles-pp.mnt_get_write_access
      0.79 ±  5%      -0.2        0.57 ±  4%  perf-profile.self.cycles-pp.kmem_cache_free
      0.94 ±  5%      -0.1        0.81 ±  6%  perf-profile.self.cycles-pp.lockref_put_return
      0.54 ±  2%      -0.1        0.44 ±  2%  perf-profile.self.cycles-pp.do_syscall_64
      0.26 ±  6%      -0.1        0.20 ± 10%  perf-profile.self.cycles-pp.__fput_sync
      0.29 ±  9%      -0.1        0.24 ±  2%  perf-profile.self.cycles-pp._raw_spin_lock
      0.10 ±  6%      -0.0        0.08 ±  7%  perf-profile.self.cycles-pp.lockref_get
      0.06 ±  8%      +0.0        0.07 ±  5%  perf-profile.self.cycles-pp.path_init
      0.05 ±  8%      +0.0        0.07        perf-profile.self.cycles-pp.make_vfsuid
      0.12 ±  5%      +0.0        0.14 ±  3%  perf-profile.self.cycles-pp.fd_install
      0.24 ±  6%      +0.0        0.27        perf-profile.self.cycles-pp.process_measurement
      0.05            +0.0        0.08 ±  8%  perf-profile.self.cycles-pp.dput
      0.07 ±  5%      +0.0        0.10 ±  3%  perf-profile.self.cycles-pp.check_heap_object
      0.08 ±  6%      +0.0        0.11 ±  3%  perf-profile.self.cycles-pp.ima_file_free
      0.05 ±  8%      +0.0        0.09 ±  7%  perf-profile.self.cycles-pp.security_file_alloc
      0.08 ±  5%      +0.0        0.13 ±  2%  perf-profile.self.cycles-pp.security_inode_permission
      0.06            +0.0        0.10 ±  7%  perf-profile.self.cycles-pp.__x64_sys_openat
      0.09 ±  5%      +0.0        0.14 ±  3%  perf-profile.self.cycles-pp.entry_SYSCALL_64_safe_stack
      0.06 ±  7%      +0.0        0.11 ±  5%  perf-profile.self.cycles-pp.syscall_exit_to_user_mode_prepare
      0.07 ±  5%      +0.0        0.12 ±  9%  perf-profile.self.cycles-pp.set_root
      0.09 ±  4%      +0.0        0.14 ±  4%  perf-profile.self.cycles-pp.security_file_release
      0.06            +0.0        0.11 ±  3%  perf-profile.self.cycles-pp.x64_sys_call
      0.12 ±  5%      +0.1        0.17 ±  2%  perf-profile.self.cycles-pp.syscall_exit_to_user_mode
      0.00            +0.1        0.05        perf-profile.self.cycles-pp.locks_remove_file
      0.00            +0.1        0.05        perf-profile.self.cycles-pp.security_current_getsecid_subj
      0.00            +0.1        0.05        perf-profile.self.cycles-pp.security_file_free
      0.05 ± 13%      +0.1        0.10 ±  7%  perf-profile.self.cycles-pp.rcu_all_qs
      0.00            +0.1        0.05 ±  7%  perf-profile.self.cycles-pp.dnotify_flush
      0.00            +0.1        0.05 ±  7%  perf-profile.self.cycles-pp.get_unused_fd_flags
      0.05 ±  7%      +0.1        0.10 ±  7%  perf-profile.self.cycles-pp.lookup_fast
      0.02 ± 99%      +0.1        0.08 ±  4%  perf-profile.self.cycles-pp.__x64_sys_close
      0.08 ±  7%      +0.1        0.13 ±  5%  perf-profile.self.cycles-pp.ima_file_check
      0.06 ±  8%      +0.1        0.11 ±  5%  perf-profile.self.cycles-pp.obj_cgroup_charge
      0.03 ± 70%      +0.1        0.09 ±  4%  perf-profile.self.cycles-pp.getname_flags
      0.09 ±  5%      +0.1        0.15 ±  2%  perf-profile.self.cycles-pp.do_sys_openat2
      0.00            +0.1        0.06 ±  8%  perf-profile.self.cycles-pp.alloc_empty_file
      0.08 ±  5%      +0.1        0.14 ±  5%  perf-profile.self.cycles-pp.open_last_lookups
      0.00            +0.1        0.06        perf-profile.self.cycles-pp.try_to_unlazy
      0.10 ±  5%      +0.1        0.16 ±  6%  perf-profile.self.cycles-pp.__cond_resched
      0.12 ±  4%      +0.1        0.18 ±  2%  perf-profile.self.cycles-pp.evm_file_release
      0.32 ±  9%      +0.1        0.38 ±  5%  perf-profile.self.cycles-pp.inode_permission
      0.09 ±  9%      +0.1        0.16 ±  6%  perf-profile.self.cycles-pp.mntput_no_expire
      0.00            +0.1        0.06 ±  7%  perf-profile.self.cycles-pp.check_stack_object
      0.02 ±141%      +0.1        0.08 ±  8%  perf-profile.self.cycles-pp.file_close_fd_locked
      0.02 ±141%      +0.1        0.08 ±  5%  perf-profile.self.cycles-pp.filp_flush
      0.04 ± 44%      +0.1        0.11 ±  8%  perf-profile.self.cycles-pp.walk_component
      0.00            +0.1        0.07 ±  8%  perf-profile.self.cycles-pp.refill_obj_stock
      0.07            +0.1        0.14 ±  2%  perf-profile.self.cycles-pp.__check_object_size
      0.10 ±  9%      +0.1        0.17 ±  6%  perf-profile.self.cycles-pp.__lookup_mnt
      0.10 ± 10%      +0.1        0.18 ±  9%  perf-profile.self.cycles-pp.__memcg_slab_free_hook
      0.09 ±  4%      +0.1        0.17 ±  4%  perf-profile.self.cycles-pp.mod_objcg_state
      0.39 ±  4%      +0.1        0.48 ±  2%  perf-profile.self.cycles-pp.__fsnotify_parent
      0.09 ±  4%      +0.1        0.17 ±  6%  perf-profile.self.cycles-pp.may_open
      0.08 ±  5%      +0.1        0.17 ±  3%  perf-profile.self.cycles-pp.alloc_fd
      0.10 ±  4%      +0.1        0.19 ±  3%  perf-profile.self.cycles-pp.__check_heap_object
      0.12 ± 19%      +0.1        0.21 ± 10%  perf-profile.self.cycles-pp.testcase
      0.11            +0.1        0.20 ±  3%  perf-profile.self.cycles-pp.memset_orig
      0.10 ±  3%      +0.1        0.19 ±  3%  perf-profile.self.cycles-pp.locks_remove_posix
      0.07 ±  6%      +0.1        0.18 ±  3%  perf-profile.self.cycles-pp.build_open_flags
      0.12 ±  3%      +0.1        0.23 ±  5%  perf-profile.self.cycles-pp.path_openat
      0.17 ±  2%      +0.1        0.28 ±  2%  perf-profile.self.cycles-pp.__virt_addr_valid
      0.15 ±  3%      +0.1        0.27 ±  3%  perf-profile.self.cycles-pp.__memcg_slab_post_alloc_hook
      0.14 ±  5%      +0.1        0.26 ±  2%  perf-profile.self.cycles-pp.do_open
      0.16 ±  2%      +0.1        0.30 ±  4%  perf-profile.self.cycles-pp.strncpy_from_user
      0.16 ±  4%      +0.1        0.30 ±  3%  perf-profile.self.cycles-pp.do_filp_open
      0.26 ±  6%      +0.1        0.41 ±  5%  perf-profile.self.cycles-pp.generic_permission
      0.21 ±  4%      +0.2        0.36 ±  7%  perf-profile.self.cycles-pp.step_into
      0.34 ±  8%      +0.2        0.52 ±  4%  perf-profile.self.cycles-pp.__d_lookup_rcu
      0.46 ±  2%      +0.3        0.77 ±  2%  perf-profile.self.cycles-pp.link_path_walk
     12.60            +0.3       12.93        perf-profile.self.cycles-pp.entry_SYSRETQ_unsafe_stack
      0.50 ±  3%      +0.3        0.83 ±  3%  perf-profile.self.cycles-pp.kmem_cache_alloc_noprof
      0.42 ±  3%      +0.4        0.78 ±  7%  perf-profile.self.cycles-pp.__close
      3.12            +0.5        3.58 ±  2%  perf-profile.self.cycles-pp.entry_SYSCALL_64_after_hwframe
      1.29 ±  2%      +0.5        1.77 ±  3%  perf-profile.self.cycles-pp.entry_SYSCALL_64
      0.57 ±  8%      +0.5        1.10 ±  4%  perf-profile.self.cycles-pp.open64
      0.83 ±  2%      +0.6        1.40 ±  9%  perf-profile.self.cycles-pp.do_dentry_open
      1.16 ±  6%      +0.7        1.85 ±  8%  perf-profile.self.cycles-pp.__fput
      5.64 ±  2%      +1.9        7.56        perf-profile.self.cycles-pp.syscall_return_via_sysret
      3.27 ±  5%      +2.7        5.93 ±  6%  perf-profile.self.cycles-pp.apparmor_current_getsecid_subj
     11.98            +4.8       16.83 ±  2%  perf-profile.self.cycles-pp.apparmor_file_free_security
     14.04            +9.2       23.20        perf-profile.self.cycles-pp.apparmor_file_alloc_security


***************************************************************************************************
lkp-skl-fpga01: 104 threads 2 sockets (Skylake) with 192G memory
=========================================================================================
compiler/cpufreq_governor/kconfig/mode/nr_task/rootfs/tbox_group/test/testcase:
  gcc-13/performance/x86_64-rhel-8.3/process/100%/debian-12-x86_64-20240206.cgz/lkp-skl-fpga01/open1/will-it-scale

commit: 
  55027e6899 ("Merge tag 'input-for-v6.10-rc5' of git://git.kernel.org/pub/scm/linux/kernel/git/dtor/input")
  22eddbc906 ("apparmor: try to avoid refing the label in apparmor_file_open")

55027e689933ba2e 22eddbc906d2fc507e4a01484e2 
---------------- --------------------------- 
         %stddev     %change         %stddev
             \          |                \  
      0.01 ±  3%      -0.0        0.01        mpstat.cpu.all.soft%
     19.35 ±  2%      +4.0       23.35 ±  3%  mpstat.cpu.all.usr%
     21320            -1.0%      21111        proc-vmstat.nr_kernel_stack
     12782 ±  2%      -7.8%      11784 ±  2%  proc-vmstat.nr_mapped
   4188213 ±  2%     +90.7%    7986330 ±  2%  will-it-scale.104.processes
     40271 ±  2%     +90.7%      76791 ±  2%  will-it-scale.per_process_ops
   4188213 ±  2%     +90.7%    7986330 ±  2%  will-it-scale.workload
      0.16 ± 10%     +18.1%       0.19 ±  6%  sched_debug.cfs_rq:/.h_nr_running.stddev
     86.01 ±  6%     -20.8%      68.12 ± 10%  sched_debug.cfs_rq:/.util_avg.stddev
     25.34 ±  6%     -51.7%      12.24 ±  8%  sched_debug.cpu.clock.stddev
      0.15 ± 11%     +22.0%       0.19 ±  7%  sched_debug.cpu.nr_running.stddev
  4.37e+09 ±  3%     +86.1%  8.131e+09 ±  2%  perf-stat.i.branch-instructions
      1.22 ±  5%      -0.1        1.07 ±  5%  perf-stat.i.branch-miss-rate%
  50836606 ±  2%     +59.8%   81252843 ±  3%  perf-stat.i.branch-misses
      1732            -2.8%       1683        perf-stat.i.context-switches
     12.25 ±  2%     -46.3%       6.58 ±  2%  perf-stat.i.cpi
    144.30           +11.1%     160.37        perf-stat.i.cpu-migrations
  2.28e+10 ±  3%     +86.7%  4.256e+10 ±  2%  perf-stat.i.instructions
      0.09 ±  6%     +74.9%       0.16 ±  4%  perf-stat.i.ipc
      0.92 ± 29%     -54.4%       0.42 ± 39%  perf-stat.overall.MPKI
      1.16            -0.2        1.00        perf-stat.overall.branch-miss-rate%
     12.45 ±  2%     -46.4%       6.67        perf-stat.overall.cpi
      0.08 ±  2%     +86.7%       0.15        perf-stat.overall.ipc
   1676348            -2.2%    1639350        perf-stat.overall.path-length
 4.358e+09 ±  3%     +86.0%  8.105e+09 ±  2%  perf-stat.ps.branch-instructions
  50625012 ±  2%     +59.9%   80948460 ±  2%  perf-stat.ps.branch-misses
      1726            -2.9%       1677        perf-stat.ps.context-switches
    143.46           +11.4%     159.75        perf-stat.ps.cpu-migrations
 2.273e+10 ±  3%     +86.6%  4.242e+10 ±  2%  perf-stat.ps.instructions
 7.021e+12 ±  2%     +86.5%  1.309e+13 ±  2%  perf-stat.total.instructions
     27.80           -22.5        5.26 ± 13%  perf-profile.calltrace.cycles-pp.security_file_open.do_dentry_open.do_open.path_openat.do_filp_open
     27.75           -22.5        5.22 ± 13%  perf-profile.calltrace.cycles-pp.apparmor_file_open.security_file_open.do_dentry_open.do_open.path_openat
     29.25           -21.9        7.33 ±  7%  perf-profile.calltrace.cycles-pp.do_dentry_open.do_open.path_openat.do_filp_open.do_sys_openat2
     34.76           -19.3       15.41 ±  6%  perf-profile.calltrace.cycles-pp.do_open.path_openat.do_filp_open.do_sys_openat2.__x64_sys_openat
     58.25           -10.5       47.77        perf-profile.calltrace.cycles-pp.do_sys_openat2.__x64_sys_openat.do_syscall_64.entry_SYSCALL_64_after_hwframe.open64
     58.34           -10.4       47.93        perf-profile.calltrace.cycles-pp.__x64_sys_openat.do_syscall_64.entry_SYSCALL_64_after_hwframe.open64
     58.68           -10.3       48.38        perf-profile.calltrace.cycles-pp.do_syscall_64.entry_SYSCALL_64_after_hwframe.open64
     60.03            -9.9       50.17        perf-profile.calltrace.cycles-pp.entry_SYSCALL_64_after_hwframe.open64
     52.68            -8.9       43.74 ±  2%  perf-profile.calltrace.cycles-pp.path_openat.do_filp_open.do_sys_openat2.__x64_sys_openat.do_syscall_64
     52.86            -8.8       44.08 ±  2%  perf-profile.calltrace.cycles-pp.do_filp_open.do_sys_openat2.__x64_sys_openat.do_syscall_64.entry_SYSCALL_64_after_hwframe
     73.80            -8.6       65.17        perf-profile.calltrace.cycles-pp.open64
      3.29 ±  5%      -2.3        1.02 ± 18%  perf-profile.calltrace.cycles-pp.putname.do_sys_openat2.__x64_sys_openat.do_syscall_64.entry_SYSCALL_64_after_hwframe
      1.30 ±  5%      -0.3        0.97 ±  9%  perf-profile.calltrace.cycles-pp.__legitimize_path.try_to_unlazy.complete_walk.do_open.path_openat
      1.38 ±  4%      -0.3        1.08 ±  8%  perf-profile.calltrace.cycles-pp.try_to_unlazy.complete_walk.do_open.path_openat.do_filp_open
      1.43 ±  4%      -0.3        1.14 ±  8%  perf-profile.calltrace.cycles-pp.complete_walk.do_open.path_openat.do_filp_open.do_sys_openat2
      0.56 ±  8%      +0.2        0.73 ±  6%  perf-profile.calltrace.cycles-pp.__legitimize_mnt.__legitimize_path.try_to_unlazy.complete_walk.do_open
      3.78 ±  3%      +0.3        4.06 ±  2%  perf-profile.calltrace.cycles-pp.entry_SYSRETQ_unsafe_stack.__close
      0.55 ±  3%      +0.4        0.94 ±  3%  perf-profile.calltrace.cycles-pp.kmem_cache_alloc_noprof.alloc_empty_file.path_openat.do_filp_open.do_sys_openat2
      0.63 ±  2%      +0.5        1.09        perf-profile.calltrace.cycles-pp.strncpy_from_user.getname_flags.do_sys_openat2.__x64_sys_openat.do_syscall_64
      0.85 ±  2%      +0.6        1.49        perf-profile.calltrace.cycles-pp.getname_flags.do_sys_openat2.__x64_sys_openat.do_syscall_64.entry_SYSCALL_64_after_hwframe
      0.87            +0.7        1.53        perf-profile.calltrace.cycles-pp.link_path_walk.path_openat.do_filp_open.do_sys_openat2.__x64_sys_openat
      3.15 ±  3%      +0.7        3.89        perf-profile.calltrace.cycles-pp.syscall_return_via_sysret.open64
      8.06            +0.7        8.81 ±  4%  perf-profile.calltrace.cycles-pp.entry_SYSRETQ_unsafe_stack.open64
      0.00            +0.8        0.76 ±  2%  perf-profile.calltrace.cycles-pp.__check_object_size.strncpy_from_user.getname_flags.do_sys_openat2.__x64_sys_openat
      0.00            +0.8        0.78 ±  2%  perf-profile.calltrace.cycles-pp.entry_SYSCALL_64.open64
      0.00            +0.8        0.81 ±  2%  perf-profile.calltrace.cycles-pp.entry_SYSCALL_64.__close
      2.30 ±  6%      +1.5        3.80 ± 12%  perf-profile.calltrace.cycles-pp.syscall_return_via_sysret.__close
      3.17 ±  4%      +2.5        5.66 ±  9%  perf-profile.calltrace.cycles-pp.apparmor_current_getsecid_subj.security_current_getsecid_subj.ima_file_check.security_file_post_open.do_open
      3.20 ±  4%      +2.5        5.71 ±  9%  perf-profile.calltrace.cycles-pp.security_current_getsecid_subj.ima_file_check.security_file_post_open.do_open.path_openat
      3.52 ±  3%      +2.6        6.11 ±  8%  perf-profile.calltrace.cycles-pp.ima_file_check.security_file_post_open.do_open.path_openat.do_filp_open
      3.55 ±  3%      +2.6        6.16 ±  8%  perf-profile.calltrace.cycles-pp.security_file_post_open.do_open.path_openat.do_filp_open.do_sys_openat2
     12.05            +4.9       16.92 ±  4%  perf-profile.calltrace.cycles-pp.apparmor_file_free_security.security_file_free.__fput.__x64_sys_close.do_syscall_64
     12.09            +4.9       16.98 ±  4%  perf-profile.calltrace.cycles-pp.security_file_free.__fput.__x64_sys_close.do_syscall_64.entry_SYSCALL_64_after_hwframe
     14.89            +5.7       20.57 ±  2%  perf-profile.calltrace.cycles-pp.__fput.__x64_sys_close.do_syscall_64.entry_SYSCALL_64_after_hwframe.__close
     18.30            +6.0       24.31        perf-profile.calltrace.cycles-pp.entry_SYSCALL_64_after_hwframe.__close
     16.42            +6.1       22.51 ±  2%  perf-profile.calltrace.cycles-pp.do_syscall_64.entry_SYSCALL_64_after_hwframe.__close
     15.87            +6.1       22.00 ±  2%  perf-profile.calltrace.cycles-pp.__x64_sys_close.do_syscall_64.entry_SYSCALL_64_after_hwframe.__close
     25.66            +8.4       34.10        perf-profile.calltrace.cycles-pp.__close
     15.06            +8.9       23.97        perf-profile.calltrace.cycles-pp.init_file.alloc_empty_file.path_openat.do_filp_open.do_sys_openat2
     14.03            +9.2       23.25        perf-profile.calltrace.cycles-pp.apparmor_file_alloc_security.security_file_alloc.init_file.alloc_empty_file.path_openat
     15.78            +9.4       25.16        perf-profile.calltrace.cycles-pp.alloc_empty_file.path_openat.do_filp_open.do_sys_openat2.__x64_sys_openat
     14.30            +9.4       23.69        perf-profile.calltrace.cycles-pp.security_file_alloc.init_file.alloc_empty_file.path_openat.do_filp_open
     27.78           -22.6        5.22 ± 13%  perf-profile.children.cycles-pp.apparmor_file_open
     27.80           -22.5        5.27 ± 13%  perf-profile.children.cycles-pp.security_file_open
     29.26           -21.9        7.35 ±  7%  perf-profile.children.cycles-pp.do_dentry_open
     34.78           -19.3       15.45 ±  6%  perf-profile.children.cycles-pp.do_open
     58.30           -10.5       47.84        perf-profile.children.cycles-pp.do_sys_openat2
     58.36           -10.4       47.95        perf-profile.children.cycles-pp.__x64_sys_openat
     52.72            -8.9       43.80 ±  2%  perf-profile.children.cycles-pp.path_openat
     52.89            -8.8       44.10 ±  2%  perf-profile.children.cycles-pp.do_filp_open
     73.30            -8.0       65.30        perf-profile.children.cycles-pp.open64
     75.66            -4.5       71.18        perf-profile.children.cycles-pp.do_syscall_64
     79.01            -4.2       74.84        perf-profile.children.cycles-pp.entry_SYSCALL_64_after_hwframe
      3.29 ±  5%      -2.3        1.02 ± 18%  perf-profile.children.cycles-pp.putname
      0.72 ±  5%      -0.5        0.22 ± 22%  perf-profile.children.cycles-pp.lockref_get_not_dead
      0.81 ± 10%      -0.4        0.37 ± 84%  perf-profile.children.cycles-pp.perf_mmap__push
      0.78 ± 10%      -0.4        0.35 ± 85%  perf-profile.children.cycles-pp.writen
      0.77 ± 10%      -0.4        0.35 ± 84%  perf-profile.children.cycles-pp.record__pushfn
      1.31 ±  5%      -0.3        0.98 ±  9%  perf-profile.children.cycles-pp.__legitimize_path
      1.40 ±  4%      -0.3        1.08 ±  8%  perf-profile.children.cycles-pp.try_to_unlazy
      1.44 ±  4%      -0.3        1.15 ±  8%  perf-profile.children.cycles-pp.complete_walk
      0.46 ±  9%      -0.3        0.20 ± 78%  perf-profile.children.cycles-pp.ksys_write
      0.38 ±  5%      -0.2        0.16 ± 10%  perf-profile.children.cycles-pp.mnt_get_write_access
      0.42 ± 10%      -0.2        0.19 ± 78%  perf-profile.children.cycles-pp.vfs_write
      0.33 ±  9%      -0.2        0.12 ± 86%  perf-profile.children.cycles-pp.shmem_file_write_iter
      0.29 ± 10%      -0.2        0.10 ± 81%  perf-profile.children.cycles-pp.generic_perform_write
      0.32 ± 11%      -0.1        0.25 ±  3%  perf-profile.children.cycles-pp._raw_spin_lock
      0.24            +0.0        0.26 ±  5%  perf-profile.children.cycles-pp.__hrtimer_run_queues
      0.16 ±  8%      +0.0        0.18 ±  4%  perf-profile.children.cycles-pp.update_process_times
      0.18 ±  8%      +0.0        0.21 ±  4%  perf-profile.children.cycles-pp.tick_nohz_handler
      0.08 ±  4%      +0.0        0.11        perf-profile.children.cycles-pp.ima_file_free
      0.13 ±  2%      +0.0        0.17 ±  5%  perf-profile.children.cycles-pp.fd_install
      0.31 ±  4%      +0.0        0.35 ±  2%  perf-profile.children.cycles-pp.alloc_fd
      0.08 ±  6%      +0.0        0.12 ±  4%  perf-profile.children.cycles-pp.set_root
      0.07 ±  9%      +0.0        0.11 ±  6%  perf-profile.children.cycles-pp.syscall_exit_to_user_mode_prepare
      0.11 ±  6%      +0.0        0.16 ±  3%  perf-profile.children.cycles-pp.nd_jump_root
      0.05            +0.0        0.09 ±  5%  perf-profile.children.cycles-pp.security_inode_permission
      0.06 ±  7%      +0.0        0.11 ±  3%  perf-profile.children.cycles-pp.rcu_all_qs
      0.18 ±  5%      +0.0        0.22 ±  4%  perf-profile.children.cycles-pp.path_init
      0.09 ±  9%      +0.0        0.14 ±  8%  perf-profile.children.cycles-pp.mntput_no_expire
      0.06            +0.1        0.11        perf-profile.children.cycles-pp.x64_sys_call
      0.00            +0.1        0.05        perf-profile.children.cycles-pp._find_next_zero_bit
      0.00            +0.1        0.05        perf-profile.children.cycles-pp.dnotify_flush
      0.00            +0.1        0.06 ±  9%  perf-profile.children.cycles-pp.get_unused_fd_flags
      0.00            +0.1        0.06 ±  9%  perf-profile.children.cycles-pp.locks_remove_file
      0.40 ±  4%      +0.1        0.46 ±  7%  perf-profile.children.cycles-pp.__fsnotify_parent
      0.00            +0.1        0.06 ±  6%  perf-profile.children.cycles-pp.check_stack_object
      0.00            +0.1        0.06 ±  9%  perf-profile.children.cycles-pp.path_get
      0.00            +0.1        0.06        perf-profile.children.cycles-pp.should_failslab
      0.07 ±  9%      +0.1        0.13 ± 10%  perf-profile.children.cycles-pp.obj_cgroup_charge
      0.00            +0.1        0.06 ±  7%  perf-profile.children.cycles-pp.make_vfsuid
      0.00            +0.1        0.07 ±  7%  perf-profile.children.cycles-pp.file_ra_state_init
      0.00            +0.1        0.07 ±  7%  perf-profile.children.cycles-pp.getname
      0.02 ±141%      +0.1        0.08 ±  5%  perf-profile.children.cycles-pp.file_close_fd_locked
      0.20 ±  9%      +0.1        0.27 ±  5%  perf-profile.children.cycles-pp.file_close_fd
      0.09 ±  5%      +0.1        0.16 ±  3%  perf-profile.children.cycles-pp.mod_objcg_state
      0.00            +0.1        0.07 ± 10%  perf-profile.children.cycles-pp.refill_obj_stock
      0.10 ±  3%      +0.1        0.17 ±  4%  perf-profile.children.cycles-pp.__lookup_mnt
      0.10 ±  6%      +0.1        0.19 ±  2%  perf-profile.children.cycles-pp.__check_heap_object
      0.15 ±  3%      +0.1        0.24 ±  3%  perf-profile.children.cycles-pp.walk_component
      0.10            +0.1        0.20 ±  2%  perf-profile.children.cycles-pp.locks_remove_posix
      0.12 ±  3%      +0.1        0.22 ±  5%  perf-profile.children.cycles-pp.memset_orig
      0.23 ±  4%      +0.1        0.33        perf-profile.children.cycles-pp.__d_lookup_rcu
      0.19 ±  3%      +0.1        0.30        perf-profile.children.cycles-pp.__virt_addr_valid
      0.24 ±  5%      +0.1        0.34 ± 14%  perf-profile.children.cycles-pp.syscall_exit_to_user_mode
      0.16 ±  3%      +0.1        0.28 ±  3%  perf-profile.children.cycles-pp.__cond_resched
      0.08 ±  6%      +0.1        0.19 ±  4%  perf-profile.children.cycles-pp.build_open_flags
      0.11 ± 19%      +0.1        0.24 ± 11%  perf-profile.children.cycles-pp.testcase
      0.26 ±  3%      +0.1        0.40        perf-profile.children.cycles-pp.lookup_fast
      0.17 ±  6%      +0.2        0.32 ±  3%  perf-profile.children.cycles-pp.generic_permission
      0.22 ±  6%      +0.2        0.38 ±  6%  perf-profile.children.cycles-pp.__memcg_slab_free_hook
      0.30 ±  2%      +0.2        0.46 ±  2%  perf-profile.children.cycles-pp.check_heap_object
      0.17 ±  2%      +0.2        0.33        perf-profile.children.cycles-pp.filp_flush
      0.57 ±  8%      +0.2        0.73 ±  6%  perf-profile.children.cycles-pp.__legitimize_mnt
      0.34 ±  2%      +0.2        0.50 ±  2%  perf-profile.children.cycles-pp.may_open
      0.28 ±  4%      +0.2        0.46 ±  3%  perf-profile.children.cycles-pp.__memcg_slab_post_alloc_hook
      0.28 ±  2%      +0.2        0.46 ±  2%  perf-profile.children.cycles-pp.step_into
      0.30 ±  2%      +0.2        0.50 ±  2%  perf-profile.children.cycles-pp.open_last_lookups
      0.42            +0.2        0.64        perf-profile.children.cycles-pp.inode_permission
      0.48 ±  2%      +0.3        0.80 ±  2%  perf-profile.children.cycles-pp.__check_object_size
      0.63 ±  2%      +0.5        1.10        perf-profile.children.cycles-pp.strncpy_from_user
      1.41            +0.6        2.01 ±  2%  perf-profile.children.cycles-pp.entry_SYSCALL_64
      0.85 ±  2%      +0.6        1.49        perf-profile.children.cycles-pp.getname_flags
      0.88            +0.7        1.55        perf-profile.children.cycles-pp.link_path_walk
      0.95 ±  2%      +0.7        1.62 ±  2%  perf-profile.children.cycles-pp.kmem_cache_alloc_noprof
      5.56 ±  2%      +2.3        7.82 ±  5%  perf-profile.children.cycles-pp.syscall_return_via_sysret
      3.17 ±  4%      +2.5        5.66 ±  9%  perf-profile.children.cycles-pp.apparmor_current_getsecid_subj
      3.20 ±  4%      +2.5        5.72 ±  9%  perf-profile.children.cycles-pp.security_current_getsecid_subj
      3.53 ±  3%      +2.6        6.12 ±  8%  perf-profile.children.cycles-pp.ima_file_check
      3.56 ±  3%      +2.6        6.16 ±  8%  perf-profile.children.cycles-pp.security_file_post_open
     12.07            +4.9       16.94 ±  4%  perf-profile.children.cycles-pp.apparmor_file_free_security
     12.10            +4.9       16.98 ±  4%  perf-profile.children.cycles-pp.security_file_free
     14.93            +5.7       20.62 ±  2%  perf-profile.children.cycles-pp.__fput
     15.88            +6.1       22.02 ±  2%  perf-profile.children.cycles-pp.__x64_sys_close
     25.75            +8.5       34.26        perf-profile.children.cycles-pp.__close
     15.08            +8.9       24.00        perf-profile.children.cycles-pp.init_file
     14.05            +9.2       23.27        perf-profile.children.cycles-pp.apparmor_file_alloc_security
     14.31            +9.4       23.70        perf-profile.children.cycles-pp.security_file_alloc
     15.80            +9.4       25.19        perf-profile.children.cycles-pp.alloc_empty_file
     27.68           -22.5        5.20 ± 13%  perf-profile.self.cycles-pp.apparmor_file_open
      3.28 ±  5%      -2.3        1.02 ± 18%  perf-profile.self.cycles-pp.putname
      0.72 ±  5%      -0.5        0.22 ± 21%  perf-profile.self.cycles-pp.lockref_get_not_dead
      0.76 ± 10%      -0.5        0.29 ± 21%  perf-profile.self.cycles-pp.init_file
      0.38 ±  5%      -0.2        0.16 ± 10%  perf-profile.self.cycles-pp.mnt_get_write_access
      0.78 ±  9%      -0.2        0.61 ±  7%  perf-profile.self.cycles-pp.kmem_cache_free
      0.32 ± 11%      -0.1        0.24 ±  4%  perf-profile.self.cycles-pp._raw_spin_lock
      0.04 ± 44%      +0.0        0.07 ±  7%  perf-profile.self.cycles-pp.try_to_unlazy
      0.05            +0.0        0.08 ±  6%  perf-profile.self.cycles-pp.dput
      0.08 ±  4%      +0.0        0.11 ±  4%  perf-profile.self.cycles-pp.ima_file_free
      0.10 ±  3%      +0.0        0.13 ±  3%  perf-profile.self.cycles-pp.entry_SYSCALL_64_safe_stack
      0.06 ±  6%      +0.0        0.09 ±  5%  perf-profile.self.cycles-pp.rcu_all_qs
      0.07 ±  7%      +0.0        0.10 ±  7%  perf-profile.self.cycles-pp.syscall_exit_to_user_mode_prepare
      0.05 ±  8%      +0.0        0.09 ±  5%  perf-profile.self.cycles-pp.security_file_alloc
      0.07 ±  5%      +0.0        0.11 ±  4%  perf-profile.self.cycles-pp.set_root
      0.05            +0.0        0.09 ±  4%  perf-profile.self.cycles-pp.security_inode_permission
      0.06            +0.0        0.10 ±  3%  perf-profile.self.cycles-pp.__x64_sys_openat
      0.10 ±  5%      +0.0        0.14 ±  2%  perf-profile.self.cycles-pp.security_file_release
      0.11 ± 12%      +0.0        0.15 ±  4%  perf-profile.self.cycles-pp.do_sys_openat2
      0.06            +0.0        0.10 ±  4%  perf-profile.self.cycles-pp.check_heap_object
      0.09 ±  9%      +0.0        0.14 ±  7%  perf-profile.self.cycles-pp.mntput_no_expire
      0.06 ±  6%      +0.0        0.10 ±  4%  perf-profile.self.cycles-pp.x64_sys_call
      0.00            +0.1        0.05        perf-profile.self.cycles-pp.dnotify_flush
      0.00            +0.1        0.05        perf-profile.self.cycles-pp.file_close_fd
      0.00            +0.1        0.05        perf-profile.self.cycles-pp.locks_remove_file
      0.23 ±  3%      +0.1        0.28 ±  3%  perf-profile.self.cycles-pp.inode_permission
      0.00            +0.1        0.05 ±  7%  perf-profile.self.cycles-pp.complete_walk
      0.00            +0.1        0.05 ±  7%  perf-profile.self.cycles-pp.get_unused_fd_flags
      0.05 ±  7%      +0.1        0.10 ±  7%  perf-profile.self.cycles-pp.obj_cgroup_charge
      0.00            +0.1        0.05 ±  8%  perf-profile.self.cycles-pp.check_stack_object
      0.40 ±  4%      +0.1        0.45 ±  7%  perf-profile.self.cycles-pp.__fsnotify_parent
      0.00            +0.1        0.06 ±  9%  perf-profile.self.cycles-pp.alloc_empty_file
      0.03 ± 70%      +0.1        0.09 ±  4%  perf-profile.self.cycles-pp.getname_flags
      0.00            +0.1        0.06 ±  9%  perf-profile.self.cycles-pp.security_current_getsecid_subj
      0.08            +0.1        0.14 ±  6%  perf-profile.self.cycles-pp.ima_file_check
      0.02 ± 99%      +0.1        0.08 ±  5%  perf-profile.self.cycles-pp.__x64_sys_close
      0.00            +0.1        0.06        perf-profile.self.cycles-pp.lookup_fast
      0.00            +0.1        0.06        perf-profile.self.cycles-pp.make_vfsuid
      0.10 ±  5%      +0.1        0.16 ±  5%  perf-profile.self.cycles-pp.__cond_resched
      0.10 ±  9%      +0.1        0.17 ±  7%  perf-profile.self.cycles-pp.__memcg_slab_free_hook
      0.13 ±  8%      +0.1        0.19 ± 21%  perf-profile.self.cycles-pp.syscall_exit_to_user_mode
      0.06 ±  6%      +0.1        0.12 ±  4%  perf-profile.self.cycles-pp.__check_object_size
      0.02 ±141%      +0.1        0.08 ±  5%  perf-profile.self.cycles-pp.filp_flush
      0.09 ±  5%      +0.1        0.16 ±  3%  perf-profile.self.cycles-pp.may_open
      0.09 ±  5%      +0.1        0.16 ±  2%  perf-profile.self.cycles-pp.mod_objcg_state
      0.00            +0.1        0.07 ± 10%  perf-profile.self.cycles-pp.refill_obj_stock
      0.09 ±  6%      +0.1        0.16 ±  3%  perf-profile.self.cycles-pp.__lookup_mnt
      0.08 ±  5%      +0.1        0.16 ±  3%  perf-profile.self.cycles-pp.alloc_fd
      0.00            +0.1        0.08 ±  8%  perf-profile.self.cycles-pp.file_close_fd_locked
      0.10 ±  6%      +0.1        0.18 ±  4%  perf-profile.self.cycles-pp.__check_heap_object
      0.09 ±  4%      +0.1        0.18 ±  3%  perf-profile.self.cycles-pp.open_last_lookups
      0.10 ±  4%      +0.1        0.19        perf-profile.self.cycles-pp.locks_remove_posix
      0.17 ±  4%      +0.1        0.26 ±  2%  perf-profile.self.cycles-pp.__memcg_slab_post_alloc_hook
      0.18 ±  5%      +0.1        0.28 ±  3%  perf-profile.self.cycles-pp.do_open
      0.12 ±  4%      +0.1        0.21 ±  5%  perf-profile.self.cycles-pp.memset_orig
      0.22 ±  3%      +0.1        0.32 ±  2%  perf-profile.self.cycles-pp.__d_lookup_rcu
      0.18 ±  3%      +0.1        0.28        perf-profile.self.cycles-pp.__virt_addr_valid
      0.13 ±  4%      +0.1        0.23 ±  6%  perf-profile.self.cycles-pp.path_openat
      0.08 ±  6%      +0.1        0.18 ±  5%  perf-profile.self.cycles-pp.build_open_flags
      0.18 ±  2%      +0.1        0.29        perf-profile.self.cycles-pp.step_into
      0.08 ± 21%      +0.1        0.20 ± 12%  perf-profile.self.cycles-pp.testcase
      0.16 ±  5%      +0.1        0.29 ±  3%  perf-profile.self.cycles-pp.do_filp_open
      0.15 ±  7%      +0.1        0.28 ±  2%  perf-profile.self.cycles-pp.generic_permission
      0.16 ±  4%      +0.1        0.30 ±  3%  perf-profile.self.cycles-pp.strncpy_from_user
      0.56 ±  7%      +0.2        0.72 ±  6%  perf-profile.self.cycles-pp.__legitimize_mnt
      0.30            +0.3        0.55        perf-profile.self.cycles-pp.link_path_walk
      0.43 ±  3%      +0.3        0.73 ± 12%  perf-profile.self.cycles-pp.__close
      0.49            +0.3        0.82 ±  3%  perf-profile.self.cycles-pp.kmem_cache_alloc_noprof
      3.36 ±  3%      +0.3        3.70        perf-profile.self.cycles-pp.entry_SYSCALL_64_after_hwframe
      1.23 ±  6%      +0.5        1.70 ±  4%  perf-profile.self.cycles-pp.__fput
      1.28            +0.5        1.77 ±  3%  perf-profile.self.cycles-pp.entry_SYSCALL_64
      0.58 ±  6%      +0.5        1.10 ±  3%  perf-profile.self.cycles-pp.open64
      0.78 ±  5%      +0.6        1.40 ± 10%  perf-profile.self.cycles-pp.do_dentry_open
      5.55 ±  2%      +2.3        7.82 ±  5%  perf-profile.self.cycles-pp.syscall_return_via_sysret
      3.16 ±  4%      +2.5        5.63 ±  9%  perf-profile.self.cycles-pp.apparmor_current_getsecid_subj
     12.02            +4.8       16.87 ±  4%  perf-profile.self.cycles-pp.apparmor_file_free_security
     13.98            +9.2       23.16        perf-profile.self.cycles-pp.apparmor_file_alloc_security





Disclaimer:
Results have been estimated based on internal Intel analysis and are provided
for informational purposes only. Any difference in system hardware or software
design or configuration may affect actual performance.


-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

