Return-Path: <linux-security-module-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6683EC636D3
	for <linux-security-module@archiver.kernel.org>; Mon,  6 Feb 2023 17:28:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230157AbjBFR2f (ORCPT
        <rfc822;linux-security-module@archiver.kernel.org>);
        Mon, 6 Feb 2023 12:28:35 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35082 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230334AbjBFR2Y (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Mon, 6 Feb 2023 12:28:24 -0500
Received: from alln-iport-1.cisco.com (alln-iport-1.cisco.com [173.37.142.88])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DD3CB279B8
        for <linux-security-module@vger.kernel.org>; Mon,  6 Feb 2023 09:28:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=cisco.com; i=@cisco.com; l=2556; q=dns/txt; s=iport;
  t=1675704490; x=1676914090;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=PXUXI6sh2/CNbGibSBKLAWXOTESpcWCb2RhwtnVtFRk=;
  b=KIc3HMWPSmjWOyl5H4bqrlgoQvOXG9kqbPN/Oppdfbbode0yH34G0hAS
   EN1PQvTbRPNnIjP9oLjWMWoKI+ulLwb8OhO7aMyrkg9VeoUJMclHFivs/
   K+A8Y3sb6JUeNZ6m3Q/77O47SR6DXNaHtc68SYJvGs18NvZZ/lbfM2XsF
   0=;
X-IPAS-Result: =?us-ascii?q?A0AZAADkN+FjmIgNJK1aHAEBAQEBAQcBARIBAQQEAQFAg?=
 =?us-ascii?q?TsHAQELAYFaUoEHWzpFiB4DhFBfiCEDhV+MLIoJgSyBJQNWDwEBAQ0BAUQEA?=
 =?us-ascii?q?QGBVAGDMgKFJwIlNAkOAQIEAQEBAQMCAwEBAQEBAQMBAQUBAQECAQcEFAEBA?=
 =?us-ascii?q?QEBAQEBHhkFDhAnhWgNhlUBAQEBAgESKAYBATcBBAsCAQgSBh4QECIXDgIED?=
 =?us-ascii?q?gUiglyDACMDAZ50AYE/AoofeIE0gQGCCAEBBgQEnx8JgUABkSYnHIFJRIEVg?=
 =?us-ascii?q?yo+gmICgWCGP4EMkyqIMQqBN3WBJA6BRoELAgkCEXOBGQh+NwNEHUADRjIKP?=
 =?us-ascii?q?zULC0orGhsHgQYqKBUDBAQDAgYTAyICDSgxFAQpEw0nJmkJAgMiYgMDBCgtC?=
 =?us-ascii?q?SAfBxURJDwHVjUBBQIPHzcGAwkDAh+BbiQFAwsVKkcECDYFBhw0EgIIDxIPB?=
 =?us-ascii?q?iZDDkI3NBMGXAEpCw4RA0+BTgQvgVoKBgEpJqBbexQmYnBfEcM5CoN0oTODa?=
 =?us-ascii?q?IximFUtlyOCTp9dhUMCBAIEBQIOAQEGgWI6gVtwFYMiUhkPgRuNBRmDWZJOd?=
 =?us-ascii?q?TsCBwsBAQMJi3ABAQ?=
IronPort-PHdr: A9a23:g+vqcxZ9p4OBoVm2SLVROIP/LTAphN3EVzX9orIriLNLJ6Kk+Zmqf
 EnS/u5kg1KBW4LHo+lFhOzbv+GFOyQA7J+NvWpEfMlKUBkI2skTlhYrVciCD0CzJfX2bis8S
 cJFUlIt/3yyPUVPXsjkYFiHqXyp5jlUERL6ZmJI
IronPort-Data: A9a23:oUKWXatmSc4x4vF2rjWpULC/G+fnVJdeMUV32f8akzHdYApBsoF/q
 tZmKWzSbK3fYTTxeNpzaYTn8BsF75TSy9BmT1Zs/Cg9HngVgMeUXt7xwmUckM+xwmwvaGo9s
 q3yv/GZdJhcokf0/0vraP64xZVF/fngbqLmD+LZMTxGSwZhSSMw4TpugOdRbrRA2bBVOCvQ/
 4KtyyHjEAX9gWUsaDpKs/vrRC5H5ZwehhtJ5jTSWtgT1LPuvyF9JI4SI6i3M0z5TuF8dgJtb
 7+epF0R1jqxEyYFUrtJoJ6iGqE5auK60Ty1t5Zjc/PKbi6uCcAF+v1T2PI0MS+7gtgS9jx74
 I0lWZeYEW/FMkBQ8QgQe0EwLs1wAUFJ0LTtC1KmsOXD82PheUPp5PRVXXNrLKRNr46bAUkWn
 RAZADkJahbGjOWszffgDOJtnc8kasLsOevzuFk5kmqfVqhgGMuFGv6UjTNb9G9YasRmBvbXY
 84IbxJkbQ/LZFtEPVJ/5JcWwbnw3yGiLGIwRFS9r5EWuGbR7TBIgLGuPtHTe9OUQ4JxtxPNz
 o7B1z2pXk5FXDCF8hKB83SxlqrUkCjmQoMOBfi98fJ3hFC72GMeElsVWEG9rP3/jVSxM/pQM
 UEb0icor6U28E2gCNL6WnWFTGWstxoYXZ9bFPc3rVrLwavP6AHfDW8BJtJcVDA4nMQcbxYz1
 3bZo/3ODwRql7yuGEDA557B+FteJhMpBWMFYCYFSy4M7N/ivJw/g3rzojBLTffdYjrdRG2Y/
 tyakMQtr+5J05BThs1X6XiC0m30/cSTJuIgzliPBgqYAhVFiJlJjmBCwXfB5PBMZL6DR1ibv
 XVsdyO2s71WUMvleMBgvIww8FyB7vKBNnjXhkRiWsJn/DW28HnldodViN2fGKuLGpheEdMKS
 BaM0e+02HO1FCH0BUOQS9nqY/nGNYC6SbzYugn8N7KimKRZeg6d5z1JbkWNxW3rm0VEufhhZ
 srFK5/8VyZDWfwPIN+KqwE1jORDKscWmD27eHwH50/PPUe2PSTMEu5VbDNikMhgtPnbyOkqz
 zqvH5Lal0oAOAEPSiLW6oUUZUsbNmQ2AIueliCkXrDrH+aSI0l4U6W56ep4I+RNxv0J/s+Wp
 SvVchEDlzLCaYjvdF/ihoZLMu2/BP6SbBsTYEQRALpf8yV6PNv2tf9AH3b1FJF+nNFeITdPZ
 6FtU6297j5nE1wrJxx1gUHBkbFf
IronPort-HdrOrdr: A9a23:H+Ebm6Hwet79k3mNpLqFQ5HXdLJyesId70hD6qkvc3Jom52j+P
 xGws526fatskdsZJkh8erwXJVp2RvnhNJICPoqTMiftW7dySSVxeBZnMbfKljbehEWmdQtrZ
 uIH5IOauEYSGIK8PoSgzPIXerIouP3i5xA7N22pxwGIGEaCJ2IrT0JcDpzeXcGIzWucKBJba
 Z0kfA3wQZIF05nC/iTNz0gZazuttfLnJXpbVotHBg88jSDijuu9frTDwWY9g12aUIP/Z4StU
 z+1yDp7KSqtP+2jjXG0XXI0phQkNz9jvNeGc23jNQPIDmEsHfpWG0hYczAgNkGmpDr1L8Yqq
 iJn/7mBbU115rlRBD2nfIq4Xin7N9h0Q669bbSuwqcnSWwfkNKNyMGv/MATvMcgHBQ5u2VF8
 lwrjmkXtNsfGP9tTW46N7SWx5wkE2o5XIkjO4IlnRaFZATcblLsOUkjQto+bo7bVTHAbocYa
 BTJdCZ4OwTfUKRbnjfsGUqyNuwXm4rFhPDRkQZoMSa3zVfgXg8liIjtYYit2ZF8Ih4R4hP5u
 zCPKgtnLZSTtUOZaY4AOsaW8O4BmHEXBqJOmOPJlbsEr0BJhv22tXKyaRw4PvvdI0DzZM0lp
 iEWFREtXQqc0arEsGK1I0jyGG7fIx8Z0WY9ihz3ekNhlSnfsuZDcSqciFdr/ed
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-AV: E=Sophos;i="5.97,276,1669075200"; 
   d="scan'208";a="56010577"
Received: from alln-core-3.cisco.com ([173.36.13.136])
  by alln-iport-1.cisco.com with ESMTP/TLS/DHE-RSA-SEED-SHA; 06 Feb 2023 17:28:09 +0000
Received: from mail.cisco.com (xfe-aln-003.cisco.com [173.37.135.123])
        by alln-core-3.cisco.com (8.15.2/8.15.2) with ESMTPS id 316HS9gd009180
        (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=OK);
        Mon, 6 Feb 2023 17:28:09 GMT
Received: from xfe-rtp-002.cisco.com (64.101.210.232) by xfe-aln-003.cisco.com
 (173.37.135.123) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1118.9; Mon, 6 Feb 2023
 11:28:09 -0600
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (64.101.32.56) by
 xfe-rtp-002.cisco.com (64.101.210.232) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1118.9
 via Frontend Transport; Mon, 6 Feb 2023 12:28:09 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=CFbfW7tPzvoXCLdj401vBkMGiymtq38A6gxpu5F9vBzEFsTpxdehSz/DxWOaENvb9Ve22QAdFyniMM4qyClH6wLRquYu3mdhCtx+/by4rVmJKwdRUOE8hhyGWkxJYPx+LrMBZVYJFobDqwd0Ew41+BGUOZ9glSepnIVgffzHB4DXnjlSpKOupRRynhagTyz94jZgfyH3+AOFd+PkkpKsG5plJrrqCiCKx2Zp8SokLDdefsBucfW9ib0n0j97TMmOQPrTa2LGV/6vuSY1EwIFFkb5CebtY2roksPNOAPq31zl8GZWlVMXSFLi8KsQ7Hh8VP2zLT79nzkgNHV0jWXLlw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=54x0rHYZMIMHdN185uczRgeMdWWniW1rymVu2wBeZwg=;
 b=Rs3vftyL1AiJoRboXOkK6jly3dcBSIEOnDdwNgyNjIY/iTNZ9e6OBzsmLOSbP0Sitz7E1NWBbqNgrt3nBP5nW0EO2/3KsERU9B3uc2Evab0OMky4S0C8d/ClPG+tiz8QlrhOBToUI8IbTynFpQbPxKH6MteL/baIg4myhBE0CSlclVRk7eU/9VHotEdpV9Gh0o07Ia9lUlBwmwPnhpugRk1MEkii9Lr4RQV511mwKZPU3HVnqh6gXGslNSkL8pViAqYpR7jAAYPcXX63ns1K8lZJUnkgW1sp7tsP1L7OFRpXO64kVYI3nV+PUify4wwweFX6vfsfoWHIlPHKqv5Qpg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=cisco.com; dmarc=pass action=none header.from=cisco.com;
 dkim=pass header.d=cisco.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cisco.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=54x0rHYZMIMHdN185uczRgeMdWWniW1rymVu2wBeZwg=;
 b=O2aFGe8Lv1ExmDbPpa0V7ObYz6nWwMQD/sKebVaT3JmQpFAgS3dpq/GNqA+8t3yfRPGUOpDo3QIqROmYmDFbgh+MW+ZDSuADiUCJm6xG01nqRgtkQBvOWJKhcC3g6NLmu7eh94ukMn+kkQOmOSslKbnlN77qQNUbE9ftMvtXwNU=
Received: from SN6PR11MB3088.namprd11.prod.outlook.com (2603:10b6:805:ce::22)
 by DS0PR11MB8182.namprd11.prod.outlook.com (2603:10b6:8:163::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6043.30; Mon, 6 Feb
 2023 17:28:07 +0000
Received: from SN6PR11MB3088.namprd11.prod.outlook.com
 ([fe80::c8d8:e933:bcdd:899e]) by SN6PR11MB3088.namprd11.prod.outlook.com
 ([fe80::c8d8:e933:bcdd:899e%5]) with mapi id 15.20.6064.034; Mon, 6 Feb 2023
 17:28:07 +0000
From:   "Serge Hallyn (shallyn)" <shallyn@cisco.com>
To:     "Dr. Greg" <greg@enjellic.com>
CC:     "linux-security-module@vger.kernel.org" 
        <linux-security-module@vger.kernel.org>
Subject: Re: [PATCH 04/14] Implement CAP_TRUST capability.
Thread-Topic: [PATCH 04/14] Implement CAP_TRUST capability.
Thread-Index: AQHZOlBf+LQrG1ZyskOsPfBHvgfezA==
Date:   Mon, 6 Feb 2023 17:28:06 +0000
Message-ID: <Y+E4pe8T7Z1ekJqo@jerom>
References: <20230204050954.11583-1-greg@enjellic.com>
 <20230204050954.11583-5-greg@enjellic.com>
In-Reply-To: <20230204050954.11583-5-greg@enjellic.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=cisco.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SN6PR11MB3088:EE_|DS0PR11MB8182:EE_
x-ms-office365-filtering-correlation-id: 0fcdee0b-2738-49e7-ed4b-08db08678299
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: MX3MzY5lJwuD+Mevn4QcdUmOjxY2yzF2JGqdwW2JPyCHHKQOfj3H0kWTa1GKqqfD3xoc8rY7idPQEwjomi4MstdwUI3fzpJYnctyg1jpyzCM0R0bZCc8opp7DnZntgStBfoEHbIRe6QrGQ8+qqtUBVDpoJ52zUU5vLUHAeuRJq/2ovaqIDBT76JQ7eT7xCvUq+Co+dhRM/snG4Fd9lR5steP7R9uSDL1E530KE2MJU3QWwX8FOlYEqU/S7x9AXoUZPUOiWgPXEbPCucnQ818ua55sxw+cX9gaRY47G8Ha0YC7M+yqu/6mdKtH9kvXdBi265H9owwAD34vaHTpkC7ErVKt9VPOBUXp+F7XeCWYVuzOWj6SAKDpKdn9vw/8jX5bM6iaZY5cxf/Hjf7WzTvUAVxMITTk4fIm9vZH8F2hguEkQNfz6A3FhG+6rJaZmROmVPUpke6RxAPB0lNgxEBJLrNVC3X89QNvS514g5wkYh3QVUYKdOAhxTmcWavUPjaPOevzffDRXf9CZqkc6rjoqX3I/GRWlGE7oLg+Z6n9HQmaOVzQ6pQsYGO1orXG6lLvyByzfb1/BL7nEpgW/m86bDgRPCJQKrVBZ/U6jz7Rs5BIFxm+7xXMq8YLoYWTU97hkCxILAtvhxyaIfNpFT+o0qoWcjK985BzQG2+/J2oC6EqsHdQRAzde6yblxxUdrUw38bP751NGdxX1roW27nAL5jdu60UrzPjPFoIZ36fjk=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN6PR11MB3088.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230025)(7916004)(136003)(396003)(366004)(39860400002)(346002)(376002)(451199018)(8936002)(41300700001)(83380400001)(38100700002)(86362001)(2906002)(38070700005)(122000001)(33716001)(186003)(5660300002)(6916009)(64756008)(9686003)(316002)(26005)(66556008)(66476007)(6512007)(6506007)(71200400001)(4326008)(66946007)(66446008)(76116006)(6486002)(8676002)(478600001)(67856001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?glEr6sBZashVYGZBcsfv5/pWY969dJ+b83tT4VIdPsmgm0/iKARv5VI2MNWe?=
 =?us-ascii?Q?fKyu9QjezXT17dMQzSugnwcDOLZzisz1B8YOrUXE+gAXgjKLXfBII1XzisJv?=
 =?us-ascii?Q?3GwOWrqUYjdQYdkDxCevpiESy+1nvE25sUYLYkKy+BueNslUiZ2IkdCQwwuD?=
 =?us-ascii?Q?426qeIdQznE/vkkNN7D6qRAHiSv7e0wxu1WnU01iYoEAdKnIgAnf66CVmd/V?=
 =?us-ascii?Q?wlw3P1DpgTA8yOGGLzwJil0ed2qVZzJrMs0MG2HYj2mHPyIea5O5pPR+YfNL?=
 =?us-ascii?Q?PfoVx1Me+dN80zZc39995UujEF8w1QtQFRjsJrDS9+/R2911vKteVa+4uOBx?=
 =?us-ascii?Q?AmpK2bgVdt29ZupB9n0UZddgy+lrrdca5/isStjg0j9IA6Li7HpPF8xwxzRB?=
 =?us-ascii?Q?evgyhXOcyoo+c3CTaOKaYOM+Fod5giajPwfHI8vj6MRsjLKDBYTSV11eC0Ng?=
 =?us-ascii?Q?JRnJ2p+XHj/JZ/JgPb8l4r1McezrNRfrIeYdxiqJlekvUD0n5ms2sIvJX0cU?=
 =?us-ascii?Q?eR6Lgsgn4n0Ep/BEaegbRPqMar/ml+ziqCsF90DaLfw6DqbQkMgiSJ9827iz?=
 =?us-ascii?Q?dZ20+Th0vJg5jMMDp29SW2p7Xiumk99sHSpxLtpnIydgyK2KngS+3gKasyRT?=
 =?us-ascii?Q?NELC9BJfPSvwPzZ+wuvSBJM74ygt6VAUkUAhwBrmS5mI1UmepZ0j0VwVbUxs?=
 =?us-ascii?Q?2ZALItIxUk+Hp2rAt/RHtfW+v5A0/Etn8moUaSDzICp7vrzrXmgfmlSM5KiA?=
 =?us-ascii?Q?kQq47EUMkLNcDLJUgMfICcLc0q4E1P4UTnVPOP1O+7e1PWZyGdsdrfN2f0Uj?=
 =?us-ascii?Q?RFU33RG5JKeYg9i15H7niC9ufPB2klrvl9JiuvZm7cAy+RVkcuAZQHY11pZg?=
 =?us-ascii?Q?kqg3AMwvqqr2TVOEGeGVTLV5uplR8T7o6+XG3F6icK+HsAR0g++1WqfQx26G?=
 =?us-ascii?Q?wtMqHKs1tgwTQoRu5pmFy2su/Bk/ridP4QgifkKjO1VpKuVEF7InstvjaPEd?=
 =?us-ascii?Q?wxCrVh+2HPTwN6t1JM9vdpz2tvc62vCaHr1nf/+5RLMhVu/EQeTJ1Khd7rmi?=
 =?us-ascii?Q?Yryqv1HWtDA1NwDw5WNb1Tg147LT5dQ7TyJ6qubuzPsyvsBNRcUIuYv0q0Z/?=
 =?us-ascii?Q?h+C4TMcsW90oT25cHi8jVmMMyEPL5fy5U3BTAZi7jOmHVowezb/ygqDZmemL?=
 =?us-ascii?Q?ddoJf3jdMrFzHu7FeKV/krU6txfpGPqiaPBSi2y/kSTKGprSDrPA22kwEEQ9?=
 =?us-ascii?Q?HE+4Y0e9LB+dkNpOYGy19Fdp4bHiRLHq6FvLXHjreQYQDKQzwgtqSEOOaBbD?=
 =?us-ascii?Q?x+LrEMNCI5w+nipuN5vhbYpeyrU5uADPGbcuKal1jbhq1vHU8kgzaBzA45zH?=
 =?us-ascii?Q?0jaqqbXMB7u7QyI5JhZf+MUIqY+gExjDHomoXqb+U8/8Exkw+1BFdtQAJOSC?=
 =?us-ascii?Q?bdJr9ezgaLDWYfuJe0X4cUxuXxeqZT0p8yyDopCGI+kLbj8G2U4C+/0gERtA?=
 =?us-ascii?Q?lQWVVaYcZ/mihjsMRht3OFqgUTY/+5/Dl1FYUZN2yxugqSqqscbF/sMK7sZV?=
 =?us-ascii?Q?V3RkxiqIZnFfNREbyRxcEXjbzRweWPV9N6LAL4kc?=
Content-Type: text/plain; charset="us-ascii"
Content-ID: <725BAD33E4671449976816FE8928E5D4@namprd11.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SN6PR11MB3088.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0fcdee0b-2738-49e7-ed4b-08db08678299
X-MS-Exchange-CrossTenant-originalarrivaltime: 06 Feb 2023 17:28:06.8524
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 5ae1af62-9505-4097-a69a-c1553ef7840e
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: wBToGlvaYONfk3K8JxoQzVD3b1Cy2H91Ckezn+yzZhFqLBYRu5zU2LtJadL0LH48oBtg6/R6dtNABCqdMBb/Yw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR11MB8182
X-OriginatorOrg: cisco.com
X-Outbound-SMTP-Client: 173.37.135.123, xfe-aln-003.cisco.com
X-Outbound-Node: alln-core-3.cisco.com
Precedence: bulk
List-ID: <linux-security-module.vger.kernel.org>

On Fri, Feb 03, 2023 at 11:09:44PM -0600, Dr. Greg wrote:
> TSEM was designed to support a Trust Orchestration System (TOS)
> security architecture.  A TOS based system uses the concept of a
> minimum Trusted Computing Base of utilities, referred to as trust
> orchestrators, that maintain workloads in a trusted execution
> state.  The trust orchestrators are thus, from a security
> perspective, the most privileged assets on the platform.
>=20
> Introduce the CAP_TRUST capability that is defined as a
> capability that allows a process to alter the trust status of the

This sounds like CAP_MAC_ADMIN.  Any reason not to re-use that?

> platform.  In a fully trust orchestrated system only the
> orchestrators carry this capability bit.
>=20
> In TSEM the CAP_TRUST capability allows the holder to access the
> control plane of the LSM.  This ability allows subordinate
> modeling domains to be created and managed.  Most principally the
> CAP_TRUST capability allows the holder to designate whether or
> not a process should be trusted or untrusted.
>=20
> The proposed Integrity Measurement Architecture namespaces would
> also be a candidate to use the CAP_TRUST capability.
>=20
> Signed-off-by: Greg Wettstein <greg@enjellic.com>
> ---
>  include/uapi/linux/capability.h     | 6 +++++-
>  security/selinux/include/classmap.h | 2 +-
>  2 files changed, 6 insertions(+), 2 deletions(-)
>=20
> diff --git a/include/uapi/linux/capability.h b/include/uapi/linux/capabil=
ity.h
> index 3d61a0ae055d..af677b534949 100644
> --- a/include/uapi/linux/capability.h
> +++ b/include/uapi/linux/capability.h
> @@ -417,7 +417,11 @@ struct vfs_ns_cap_data {
> =20
>  #define CAP_CHECKPOINT_RESTORE	40
> =20
> -#define CAP_LAST_CAP         CAP_CHECKPOINT_RESTORE
> +/* Allow modifications to the trust status of the system */
> +
> +#define CAP_TRUST	41
> +
> +#define CAP_LAST_CAP         CAP_TRUST
> =20
>  #define cap_valid(x) ((x) >=3D 0 && (x) <=3D CAP_LAST_CAP)
> =20
> diff --git a/security/selinux/include/classmap.h b/security/selinux/inclu=
de/classmap.h
> index a3c380775d41..e8c497c16271 100644
> --- a/security/selinux/include/classmap.h
> +++ b/security/selinux/include/classmap.h
> @@ -30,7 +30,7 @@
>  		"wake_alarm", "block_suspend", "audit_read", "perfmon", "bpf", \
>  		"checkpoint_restore"
> =20
> -#if CAP_LAST_CAP > CAP_CHECKPOINT_RESTORE
> +#if CAP_LAST_CAP > CAP_TRUST
>  #error New capability defined, please update COMMON_CAP2_PERMS.
>  #endif
> =20
> --=20
> 2.39.1
> =
