Received: from sonic311-30.consmr.mail.ne1.yahoo.com (sonic311-30.consmr.mail.ne1.yahoo.com [66.163.188.211])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 032301E8332
	for <linux-security-module@vger.kernel.org>; Mon, 16 Jun 2025 17:12:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=66.163.188.211
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750093924; cv=none; b=GaoQ9KbjWq6S0kW/8a8/XglW+KVSGK9dCP2w60wBb1A7NGtiLnAOSRQ9Sbop8W72f6bwGWSpjc/RgwS5957q+Nhnvl7VbI/qvCNMbBu+4GZsJJPMfeDCrhFAD10eTl71OWZ/8HFTO60VI7knVDWZMOeo2PbwwBSoOl+UOqjV72g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750093924; c=relaxed/simple;
	bh=z3wfm19/K2dbJBuj2N56yw8HpSPDTiCcrLHUeUHGS5c=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=NRRQdqsP54U5noSGnANhLpQw+CRcDYcNUWpBhxljkebIpSexIwSCIw9oH+XGUeBAr9uXnGp1YdkHyNP9Fw1XmRIPsjYa1dzWl0jJVS0TrCwIpbo/sdnmrhVktFxYzZk9iyCWVAm6FIKuvD8g/w2G6loe2YwyflQjWCv+NN9oc9M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=schaufler-ca.com; spf=none smtp.mailfrom=schaufler-ca.com; dkim=pass (2048-bit key) header.d=yahoo.com header.i=@yahoo.com header.b=ZKoechxQ; arc=none smtp.client-ip=66.163.188.211
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=schaufler-ca.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=schaufler-ca.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=yahoo.com header.i=@yahoo.com header.b="ZKoechxQ"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1750093920; bh=J2U4deFp5WsOwad5K79E6NvGyjG3HdmWMl4tqVrcW6g=; h=Date:Subject:To:Cc:References:From:In-Reply-To:From:Subject:Reply-To; b=ZKoechxQTclADvTNWG6OqYX9wyiOe+Cftsl26J1cnSaDxoQKNEknXx5bEFZvdu/coK6ZC43wUKKAZiMfrVhXAeeeJ/VpQrs+j1/9a9AKbIbK9et+AcHLEHzPRZIYDFmSPzNJSn2v6cgL7EPhTK3h6EOkabxyyxK3hvmzGJPux3+Y6ihHDMkcwdX+Q/P2k1NRL2FBfDU7nVDKNpzmWQHIOHNHq/UAH9wb0JhTf2hwoQyyhkzdvW5ZtY0qM4uFr5NJov68+8dZcAUaYOxh1MxrOjSuuqHa00cDkHWRfhYa/9g4XXHNlH7wNAjE+AKYPQ+c8Ep5NGCXrpQ9M75I0kY42w==
X-SONIC-DKIM-SIGN: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1750093920; bh=EmBuG7dy06KUmymNUA2r9i4E+dvxNen8eO53+EsFLJz=; h=X-Sonic-MF:Date:Subject:To:From:From:Subject; b=osaktALP37I3yCZc97LEtPDi9GarvwCn0pVHZ0YLTPMFi7lsICdv5pHabEIpVPP9GxnUscqeM5iWGQtc3QVOPyTwv6WrMj9xSW4iznN+Eo592XUfhWVMniddQ6g4+hhbKxgA/hncGjORTUMBQBD2c/HRqRQ5PlV4qG80z90W5L7k3o7+GL9tQX91luVtGokgccViD/aRYMAlARLQbhU/bduifDuzQSeh883f8THcd25wKxQt9LhNq9YodgXdrDgBthykceQ7ysSYDr6eIXsBznkmJOEMBPEXg43mgQlXItcDqdXi7hnSAPxJ/Epe64akYjNdCOeDDa2ukiLLcoHxWw==
X-YMail-OSG: 8fpnjrQVM1mU2j3inq8ipZFDaVvr0kfeTeTFwm0Mknbinv6DGtIHxPssrRCZaiT
 _5qvpYSyMujEnAtHzOeWdMrPz51KpaYeRbbQKTP92Q8IZXJmZTGu5skN2Ld8ZyzHly.VoFEBlNoT
 QWhzazo9GhnAXk1bUHrVbOjtEKr4jVOAheMmJjZvC2KMlCGyYKYFys8itUnYaL_QWq.aL8OZvi52
 zxzMAZZkB32s9XPgXjW4gbqsVWu87iLocMUhv2.oLpBDvXCcUtWFczRWsbixCiqVZvWs8j4fRq8P
 PqT4b5XT0TkdzLolVoJUL2YEzPDPeBTrW5PA8ESk6eNFoLm.i8I_W62rla8Q6Mw8HOXvGrYZMUS1
 f0cCNIwpLRSnC8xFx2XVoFqact0zJVJOOhz4ANRMkuWJT1KSqwKhYAUj2Neq2CObFQCvDibWTUGT
 bQRFVM4J4bi0zW6Lj4TZzXHzVhFs0UvZM2p76ClbbHF4RN1Jf2mtaicxWtGAHnqSrWAmhVN2FdD.
 nPH8Km7ZK2muiRIS_.bu4iW3EtetF7H2kOmdkcEZDCfKGOvI0JfIWybpvR5BNCMqJgQhLEG34rj3
 CbRJEgZyQcWo66zbRlZ_K6kf824JSdDJeD12lnf63wCWki.4iKLgohdQcs7ZOzeycHJFymAtKzma
 7jdVeYJazEdIuGmA1Ku4CYUGlTRaONL5GRP9YiyQsJL.WxvHKH3wRngv0ii2IP1Ls07E4tZM9bqi
 EUxXD5b7QZ1rYRwxFNl0ibg9tYXkV.likQng.Er_8aeM25KF2H_KZQ.U9z5UP80cVUL0eARJtseD
 jt4eH5KWm933IxyDRYPsMD5DJvyif.D72pPhGBmt3jTI_E4e.OTcgw1KS6ZyRNLKTaRr5Rq.1LSm
 alu2HKvz_CCoP1gKOQkMiZSlLWaeHXahve4kNWyES9PY6Z8Y2yXDoCAwWdaBxcZk8wh4iMctC7pa
 itElQdvc1Csg9ZZLOkIXAOMAuGOyH8nCblE9VJ85zQEJIBX3qS9mtRDk4_7Rj8Am1.WQEBCVJIn_
 MA5IwH1sOHqZN3BAlx2EhpEGzB7O_NlEj4mZ5tDrSW9mofuMMK_yWIxFq3Vl7EVTTtXORk30QeU6
 xw9nZuAnAWgADvehJ.k82t6JXY_cyjUR7rnbeEBh1dTs7AsQTNNIiL3ANlV7evWzwKUifYFizeVc
 wr6B3USvK3TohmIsLeShfhzqHZq3CQwPHUypx3Wp7yz1kG1vfcMYiXet.0IcmzVaYgzgG1B4kgTo
 NRFf4yZ8rltEYZRTPiJ4g7mW3Eub7r4aA0zc.4CXIJNGS1V0brfyjw1_vsVcXa_IF..zbqRLYaXr
 ZKDZC2CQJdp0tDc_7Rljwf8kzdFCn_0p3RLTKshkT06TUggJEASXU_SAMRkauOaQXjlQxqT_I5tF
 3YElTE7FU3GQQGnazgQlhSoHSZ_sw0pW4Qxe2Ti2z3.mwyccbKSLCKJzK.wOAT1OZxbVlhuIPqnX
 FnF53YLohwhq2lrza37CT7s7nRoqdVOtREq_reNvT4ybd_Rn77nfHO8hBs5KlFkwTGjJxPYIHUNm
 2lhdUebbbfa4v2joZJyQ5GRt1GE2W9JNUN5GjrUtD_kztpJs0Gsgn2ppopIXgTLip.zWuhVO0lBU
 Wnv4aiulDJYRzb0xH5j8ROpqlz0jbVfLnGAeVMyEc31UFXwjfX2XTbdi.Waup2VNPDbH17aZXcut
 hOz5rZDFcCG5wWH64_2qoN482YHnvuZ4R42VCXCkPo9vPN6gWD2M8YvgeCD.r7ndNf9Y_bEB9s4m
 mdV5Iq_SaASaa4H.AQi6TTaAWAV7vvfg_4n0tKxjGueGX5oK6yQMBT9GYORBsyFgU30qjYnFFcEj
 vJTej1FZLCoLkGFTkf8VwUdcZhAZ0YDZexqNdSLLxBO5Kuk8GbLWaTUhlV_uOcbhHP_3_h9LoVWm
 qQ_Ct1tR.t_XhJmidhqzwulOauzvZ5BISsfNR2iPaEVKO0LGNhBEE.N3vAWKrgnxxoK3FrgsePM6
 oMOonhmmZl9p3pe9W3YQMgMmae317DSP.SM3vBdsmmX4QBuXBR6UBPj20Qfb1MwUGy92qrsQyv76
 9G5AYZUCieS8lanfUYcTl7ll086oFboUMKCHw9gFzKIWVP02B_1qYic70S5TdEF7xqTO03Y.8F5J
 R8lFZUac2Gw4il.S.94lWDFYfZKppE6x08M38tUeZGnB5fBzj2vWyeND7AHVte2CTzyCA7mWB7gz
 8DP9TK51hWw.koxNHnOyQG0YmuTyPlgAHElqckkT0uHKpal2fWsNRQHlK7.RaiU7NmO2ZnLjJVsn
 M13vlRg27jrnAjHpEgQ--
X-Sonic-MF: <casey@schaufler-ca.com>
X-Sonic-ID: fd17b6b4-9787-4dde-af89-271d2632a6c5
Received: from sonic.gate.mail.ne1.yahoo.com by sonic311.consmr.mail.ne1.yahoo.com with HTTP; Mon, 16 Jun 2025 17:12:00 +0000
Received: by hermes--production-gq1-74d64bb7d7-lwch7 (Yahoo Inc. Hermes SMTP Server) with ESMTPA ID e7cc649d56177fe9cd5522bbbf3a3deb;
          Mon, 16 Jun 2025 17:11:57 +0000 (UTC)
Message-ID: <38c13fcb-2ed5-4b17-850e-b57562321683@schaufler-ca.com>
Date: Mon, 16 Jun 2025 10:11:55 -0700
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 5/5] smack: fix bug: invalid label of unix socket file
To: Konstantin Andreev <andreev@swemel.ru>,
 Roberto Sassu <roberto.sassu@huaweicloud.com>
Cc: linux-security-module@vger.kernel.org,
 Casey Schaufler <casey@schaufler-ca.com>
References: <20250616010745.800386-1-andreev@swemel.ru>
 <20250616010745.800386-6-andreev@swemel.ru>
 <147eb5a5c06ed28eec9cf33a877cfb200e9a6103.camel@huaweicloud.com>
 <df5f6bdd-b7f7-47df-8fc7-a5aa32e2f92a@swemel.ru>
Content-Language: en-US
From: Casey Schaufler <casey@schaufler-ca.com>
In-Reply-To: <df5f6bdd-b7f7-47df-8fc7-a5aa32e2f92a@swemel.ru>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Mailer: WebService/1.1.24021 mail.backend.jedi.jws.acl:role.jedi.acl.token.atz.jws.hermes.yahoo

On 6/16/2025 4:46 AM, Konstantin Andreev wrote:
> Roberto Sassu, 16 Jun 2025 11:05:11 +0200:
>> On Mon, 2025-06-16 at 04:07 +0300, Konstantin Andreev wrote:
>>> According to [1], the label of a UNIX domain socket (UDS)
>>>
>>> [irrelevant portion of the message deleted]
>>>
>>> diff --git a/security/smack/smack_lsm.c b/security/smack/smack_lsm.c
>>> index fb23254c8a54..1b41ae053966 100644
>>> --- a/security/smack/smack_lsm.c
>>> +++ b/security/smack/smack_lsm.c
>>> @@ -1021,6 +1021,16 @@ static int smack_inode_init_security(struct
>>> inode *inode, struct inode *dir,
>>>       bool trans_cred;
>>>       bool trans_rule;
>>>   +    /*
>>> +     * UNIX domain sockets use lower level socket data. Let
>>> +     * UDS inode have fixed * label to keep
>>> smack_inode_permission() calm
>>> +     * when called from unix_find_bsd()
>>> +     */
>>> +    if (S_ISSOCK(inode->i_mode)) {
>>> +        /* forced label, no need to save to xattrs */
>>> +        issp->smk_inode = &smack_known_star;
>>> +        goto instant_inode;
>>
>> Maybe you could also set SMK_INODE_INSTANT here and just return.
>
> Certainly.
>
> But I personally avoid duplication even of small cleanups
> and avoid multiple returns at the price of few gotos.

I generally prefer

	if (xyzzy)
		return -ESOMETHING;

to

	if (xyzzy)
		goto err_out;
	...
err_out:
	return -ESOMETHING;

I grew up in the era of "gotos considered harmful". When
err_out does more than just return a goto is fine, but a goto
that has nothing but a return is unnecessary and adds code that
needn't be there.

>
> A matter of style. Either way is fine for me.
> Let Casey decide.
>
> Konstantin
>
> [the rest of the message deleted]
>
