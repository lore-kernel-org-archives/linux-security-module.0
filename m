Received: from sonic303-28.consmr.mail.ne1.yahoo.com (sonic303-28.consmr.mail.ne1.yahoo.com [66.163.188.154])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F2D87219E0
	for <linux-security-module@vger.kernel.org>; Tue, 24 Jun 2025 23:42:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=66.163.188.154
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750808547; cv=none; b=T7o5ju3yp+ifa1namSTfCN6RMPDWsBXq/1tCNOYOoK2/iQTENE53Iryuy5jt9pPfOwaQCd742unwXn1FoTRHj62pPIttmce3Gb9/P1LqLoKJjapj780kDRQ2xFavT5EbH9RBckWnGaA8kRM0Q7UkqqYRH5PA2b6bXPEdH5VyPkk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750808547; c=relaxed/simple;
	bh=kdacCS9nwaFyrM1KUH0Avr3dQIfT6/OBwxFkhvSLeqU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=W8XkzJBCwRcfU+XiYNAxarCm8E2Zsz/l0nlc1yLiac2Hi/mHUmj5+XCfCgIJElR+3OpSSRKPuU9k7OA7vAKKQ1rnJs+KHZL6mbJVzTlpE9ySxmi4JCEP2RXg3ZFznUHoS1EslSQP0HqudxcOh7Isd3LPpfq5W4h3EOUf+Bui4Os=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=schaufler-ca.com; spf=none smtp.mailfrom=schaufler-ca.com; dkim=pass (2048-bit key) header.d=yahoo.com header.i=@yahoo.com header.b=X/kq1gJh; arc=none smtp.client-ip=66.163.188.154
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=schaufler-ca.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=schaufler-ca.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=yahoo.com header.i=@yahoo.com header.b="X/kq1gJh"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1750808539; bh=kdacCS9nwaFyrM1KUH0Avr3dQIfT6/OBwxFkhvSLeqU=; h=Date:Subject:To:Cc:References:From:In-Reply-To:From:Subject:Reply-To; b=X/kq1gJhPqbkNHxtD5b+q8JVfFU0i2w/x3Ji9z1VfrsnZOs1Bkmo9Il3yIJW/iaAmnVWwNltDTf9c/FtZwAFuAED6jclRLAj/vjcQnzAvL7QGX3SZKsnh2RuxCHMe1skcUxqEpdjSfQFKeX3xIJ449jubaVsPUZI4usRs5id2WCElEuCDOVOftKlF17jGkvOzfP9/BtTSF5NTMo0VQnTzjOfOeJaXEU28luHoJXyloaro2+0ebc14KBAu+UJ1pVxB35Wfc4i2kOfZAbxMvhZnVYnGug+xaj/Zyxv1J5TmSfiI/vDpa21oBQH9QYZnMHZ+sotudm/8upn24Utw+jSiw==
X-SONIC-DKIM-SIGN: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1750808539; bh=vDpdhXInmDDSlzwrt18vXyi/RNJ0JXeJ7JNpevbzacq=; h=X-Sonic-MF:Date:Subject:To:From:From:Subject; b=U0wb+UeRul1/eNVeJdZre3YBag6rzEmQUBRCVVj6hfVM5rcYfRcxV3NPb4VuhMjCO/7Lt2ectwPqa//RStdSOex+9vWXuJERJAQPzHWOtsK4eM1XTAfutzijiHuoJSLLTY5TEft3l27DTfUoE/usu8cPNWGzqtR2OiwYTr8TWaQFUk6ss/ld0AGPuLZFvo7gIAiXcvjqLkIneTkm7oXh9VHiF+88VCFRrQ/CrbMBX2cSq64EaJk+fKmtDg9KxgHV6I6qgflxeH+q/UNKrWXn/cUpzUGaOxBE2dVIDGQC/IKxdh8FbydjHmOSJxfYStoKcNQ/E6aaS/TFT47MSU4JPA==
X-YMail-OSG: _VqGkdUVM1kPqCMVIys8vLSd4sxC37bTaz0Tc71eOGM8RLJrXPqa35Ciu387FxG
 zDgMbyGHCI.zBfRtP62FJB.xwPp490lATPK1yOoGkWIJcBIpXEOmXRCBTXa5xg_MXZv8oIS8Pm8i
 .5b.cnSnWJkOsdK4myo4pFtUBER2q0dVjCB9itNnm1fwCSXM9QfzjW9DktezCbA3EBpS.D.Li1wy
 .LB3HwpVq9nbYWyacM2cgPlW.hqqBW2_nhKzHu.Yi1KyhjCb1TaCZ8JAbT9ezDIwitiapub0SYyO
 ElMomE391l1dbCShBihIN5ADf4gXAP8JLdZSa6_LyGEh_FI_j1tgrWuoZ_qFEnaZoOyLcFUuKAZ1
 PpIq8Sdi_LWUhLjKqZedDEFd.1a3T6RaEj8Gu6Qpc_7TP3YmmTKqpwEZssZ9f5Dy6ZPPmtPJMWGS
 kHHvAenw_1VyM7AAd7WO8tRUZH4riKiVEu6GhzH.nkDQuFE6e5nmZSU.4MTQgN6Gk5SrtzrOLa1F
 370t2DuwonsrwtSKwpjmyzvrJuKeN5h4bwzKwHj3bycory8h4WPdBHJu1oDSgMDYiBGYsOo.WONJ
 KAKMgURrms_M.YrtfWKcV9QIiRLC4muvzbdCB.JyUKz3D0JrPic_H95TojYjvfHRUMdRXfZYuvpG
 E8z..taYNQMZ_QeXaq6CquzJUyT_JOZihrua3uee02W7wkQs8bTeHvG0oa55Gyc6xW2q4goGFrep
 7pw4jzOLjqnHZZtfJ6yCIsyCDwEkLvHvME9D1Pf4HaH2hgpQ0AbG6xbXMUsPzJUovUPj7QqMcMBd
 K4vc77U7OrMw3IVVT6ocf6OqRm4eF.rowJnqVspB.Pa8niW2CQHhlmDvgmPMNQR_tbq.7Rqta9U5
 2BAKksz2l1QM64eH8v1_GzAjyUMxMVVC2bRL6xvpzSVDuQtyiPb9GZxzBHniVDM5AhqougB7Ad7r
 I3tep7SgXN3v5m6VVsYzLrHTZf0O40X6YTxZyW5Xs109XZkWpqLoh8J2x9.VtjxV8dvR6MdK6D.1
 AQJPGuWNvdTzi8vAVkw_BEagaWfbSvh_p3C5M4I27SFUfWNZVcPKX_PnZNFtXitzxyFLSAtCEwSI
 pUTFNZqu_0Yu772aaSbL6snShilW9dJwtBXAbAkEkOP.djEaVALC5SU2lTCRdVp12Z.7zPoa9arc
 nsvTDVKLNhJ2spG2R1zgS82YWwq71UTevQaPmBw6VK5N8XAkmnj7at44y9GRlIWEzb9VhKHAvE7L
 4h7WtO_1IsSq.uHwU0mnUF0OIbH5hUPljHyKdpBGwqHCtbGEcLnqqKWSkI2N4F3tY.S6hNguBzdo
 oeVdYiShVfu7uVSpNi1AAkKuhq8sHmHqCp9ZrObPmX215hw10xpMrJahprXpQ3LLUIuFs1ON1NDp
 kYnauLXtitB3Mf3gSZw8jUJOyRaIP29wQVw69P3OLCiJ9jB12nkyRnUN3MAg_tQiwLuBPL6SHeXS
 XUcMgfTKjAv996rJ.7stuOhFO4gKutbi0AkF..vQTEQjkYoHpq0Uc4dmCZuCKEwTUtyS81dL2gy1
 xZN.ZSdPWAFouaP63U3TaAXqy4fxAlCmMv6NvTCeLSn8BKed1V87tN_52lhdYlP7WoSwLOz63FA8
 bZk49QTssh5bhHeVUPyenq2hIf05CKZSGJkQ00MiSgwZJa5Yvz1SlE7.e_P4b_EgHfKAYJnTx4I3
 Cn1ln8F4l5G27UiHXOPwR4xKAVgaRzf6Hnxm7SdsD.EbaUlszZyJX8BwSsQfFaYHslBsRwMFz9El
 .Stn4uEkT9IrFDNBbo5eUIGl9OFfR0ACYK7Zy4Yoqz_EJ.rYrYOG67Wo_7lv27cmt4u6qSu4yFsX
 lDBQLQ4C5mKVC5M5iyWSG.ec80b5iWk663mCo2OtAl1WPP1g2HVAMAQurmGUuomVLI8VAxEp7GV8
 uSUOY21bikDR23WcQjvQxRYV4WWxXyt014HMp41DzC.E26JBhnq8nuZcYsGlz2GUYGsj5F06tXrM
 MfVo2JCT.WRwZFe1eZZf3TdS8P1BQKMrqm99Sucd7qqoKJ1FixllP0AWPzvJtVGlZG81Z5rU_9pj
 h1Zttu36R7wjF4iB0Tz6M5zMCd4o9JO4WcenUEu9X9RIdm2BnkxNjqQHJcS1W5rQx.IMj5eGmUfD
 zzG5UBFthALv0PmgIO7ZGhJDhrV.E_SrVsa0FqbmoEq7.ZMBgZfKZXQfbDioKKfQjHuZx8IG7GGB
 bwJgZAqhODBH_c9jyLM1yGvWIYjdfMx3tDHp7DTWGXtrEgbe3Db30zyJc6Q6lisnXAD6_oqdfuMa
 IN9E-
X-Sonic-MF: <casey@schaufler-ca.com>
X-Sonic-ID: 1aff721a-2360-4ff4-8f78-8eb3175c5cae
Received: from sonic.gate.mail.ne1.yahoo.com by sonic303.consmr.mail.ne1.yahoo.com with HTTP; Tue, 24 Jun 2025 23:42:19 +0000
Received: by hermes--production-gq1-74d64bb7d7-fddgg (Yahoo Inc. Hermes SMTP Server) with ESMTPA ID 1743715265ed9b60691641e941a96384;
          Tue, 24 Jun 2025 23:32:09 +0000 (UTC)
Message-ID: <1e36b4fe-0e6d-4897-9300-363eff94cb0f@schaufler-ca.com>
Date: Tue, 24 Jun 2025 16:32:07 -0700
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 0/2] smack: fix two bugs in setting task label
To: Konstantin Andreev <andreev@swemel.ru>
Cc: linux-security-module@vger.kernel.org,
 Casey Schaufler <casey@schaufler-ca.com>
References: <20250315015723.1357541-1-andreev@swemel.ru>
 <0c8e9341-d044-42ca-9332-2b284a0e3e5f@swemel.ru>
Content-Language: en-US
From: Casey Schaufler <casey@schaufler-ca.com>
In-Reply-To: <0c8e9341-d044-42ca-9332-2b284a0e3e5f@swemel.ru>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Mailer: WebService/1.1.24027 mail.backend.jedi.jws.acl:role.jedi.acl.token.atz.jws.hermes.yahoo

On 6/15/2025 6:52 PM, Konstantin Andreev wrote:
> Konstantin Andreev, 15/03/2025 в 04:57 по Москве:
>> These two patches have distinct subjects,
>> but work on the same object,
>>    security/smack/smack_lsm.c`do_setattr()
>> and the second patch partially overwrites first,
>> so I combine them in a series.
>> ...
>
> Hi, Casey.
>
> If you have time and you could have a look, that would be great.

I have added this to smack-next

