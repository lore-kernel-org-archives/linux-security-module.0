Received: from sonic308-15.consmr.mail.ne1.yahoo.com (sonic308-15.consmr.mail.ne1.yahoo.com [66.163.187.38])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EBEDC263C6C
	for <linux-security-module@vger.kernel.org>; Tue, 11 Mar 2025 18:10:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=66.163.187.38
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741716652; cv=none; b=NTsqpAN7jncPOPFVFtyqc4aGiYN3eQnKmF2lN84knq4otwz0xg1NxbXtoxvYtTOMtSYphD+MKy+Q4Ktu4QoUEaR8kzP771zquwuhkuqKTzKmfBeAjy5HBl7myFYn9UVOyVVRfBbQu7DYtj8NcjnzRzMiOszViqI9YpyDJIPtwVU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741716652; c=relaxed/simple;
	bh=Acuob4cZp5HQqGtOF3O2pF8wxblMNaX9gBxjgUKZnXU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=myxEeNynaSwHCjOsxNlnxTxAUqzgdOCZucaVtzA5kyCKkm9KSIn+G7obtplJl21Bi5x+dRUO0hB1SJLR1R1B7cvcR6SBD5Tfr5aU1j+plTLNQl14AauRImWuK0ZkRKCuCTEdRMZ5QhPMwVQAL5aBUrTieIZqXPiaJUH4xKHJSZQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=schaufler-ca.com; spf=none smtp.mailfrom=schaufler-ca.com; dkim=pass (2048-bit key) header.d=yahoo.com header.i=@yahoo.com header.b=pVwmjAYE; arc=none smtp.client-ip=66.163.187.38
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=schaufler-ca.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=schaufler-ca.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=yahoo.com header.i=@yahoo.com header.b="pVwmjAYE"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1741716644; bh=nEbzvrPujeoX8WEXQoqVFcKAfJX4cSsYKDJHJ/RbrrQ=; h=Date:Subject:To:Cc:References:From:In-Reply-To:From:Subject:Reply-To; b=pVwmjAYEKBbC+dzuZqysFe/196lpQwurkF0WpYvkP3SK0xmiyoPmY5tvCpLA2NqsAB4HwNOES6yl+FYko09onAar9Yh1gJzEalhA/xUn44gX1tEKF13WGww0yVnMHxw4mSu0La9eApP2d/u7Xj54hQVip06DChD/whWAfMKtZwEibcJ+2PAH7PLM2CBIbEKMZ3f6ZKRGaDWzYvT8amTB1XWECEexBQw8xtSOIJcqi8jT4Q6wIiNwUlKvLnP5p+9t9HM7TAFuJJvExJ8S/1HVS75u5DkuVOQoyhzrAqk9ueYEfjB9dETU9ZA2q1QIdJ2acZSY2NVctL2s6qpt1k/1xw==
X-SONIC-DKIM-SIGN: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1741716644; bh=v2Vjd6hbqr2YrvtZrY90QQ604q9RUP0BotKRblC73+w=; h=X-Sonic-MF:Date:Subject:To:From:From:Subject; b=pG5oZSIz265Hd5tEeWwZUhAMfWjUOj8AbHqav495w5Md9cTHKu1CLGV8MqU9uhLUcTcNebqtILN8eN/BnltE5sSBT+0q1rZo3U5wDRRB0Go+xxGydoYP0olBbTLMuZnUljxkKbzH3pEmYmePyNrIo6aPTe/cvBsxb+LaAKPHaBq2r9SS+thr1FQGPf3AQMjljGP8LtX6L1Wy4UzOfeMY3zDJGiY8GKOpPQL8iYk5Bt5Je9Pf0fWoO9lJ/dHhM3VB7DZJS41ag8YxFGfaqO9Zn8kRjKP6kINpIWPJC4MdJz+/an3KtNj+GeASgaJlt9qH/1Vi7bQmrkXAyKU1PbfLow==
X-YMail-OSG: .wZr5ncVM1nLXsGf0Hb2jsp1ODlxbEi.78EaDfS9fiuPO5PjxVbd08gfRwx4Qyc
 ccACPq5kQR9B5HX4UfL954pP_KQT9yOrzzBGnuKpZXePj1zU3SL16kZt0Y9BjJPIw4mwYtp5zAiK
 aRtpI3cIhnI.HZMf7s_gY.DLCZxS7X125iEpfzv7gqfAPsGLMy.7Tp5PmkW6jBACJGJBWX3_BZKu
 raTLe1dgb_iJwD0DD1Sr_k80ee8_meLAZFlyTW9yeRVbxs2aUx3FGb9QdU5XA6V.Y5mhrNstIqrk
 mGgCQHNjrCVaD1b_3MT3Uf64Uj1RFMK.K08ON4XwIbbizu9mnE78qRDXh0lrfYuEeqVaVsRz7kyw
 C095T8KZOjKaMlk3CiYTPwWAwzlJoeTxMp8Nfoqd43ysflA5rFkuXY1lmlFyOULKdfeK9hs7SEC5
 MJfeZJrZPIG_PS4ljj4JueQWZ_mY_SXM_o4AI9KME8GNZlJrPiqLaGzS6secBvsyCqaJH7QNi1OT
 U3QxTVRBixQUnavq4M7IZ5miwgqX9SwRoEf32csATJxXlDD1dxQVPpGXg1LteyPqySHEs7kWhcOv
 x63VLhemSk5ZMujqc2NltzNt9i6Gjc_QVdYyeteqcMn9F9p84JDKjXo5ovl5cHLMK0SH5XnKx8sT
 MmHS6guABB1NRQ4if5Hna5vgoIUx1d.K_fCU80bZLHpc6IORtDTinuerREXXs9o8mx7pyArim3.V
 t9iubErnmwLnMO2sRQOOqyGIZDuvx_PK7uptXLkZ9khNZHvQkXdj4B6lCsp6l6Qp56FkJGy8.5k6
 vTE7cVw8S7FyAQHC4spx0GPWMZD3ic95XuKB_rPBaD7wz8N278HgGmfVPLlYqRdaOOJ985pCF6O3
 5yTRpPxYYPvjb2gP_AAyP75rYJjUhFcaZ4WBQzHHj73zqOtSGnlZhL3oRupeDu4b0ZayOSOkjfWR
 6OYpqQyB5loi4OsVTXRSJq8qqSh1gwZn4w5WdX1_KgbxP6V_oBur83SO_aeHl08ROwGnRMSp5EUj
 sB_CAFnRfuu0fWy2aXIwl2ZmyZebL175.xIDf8vcwbXs.AkHUIgaBzVBsoQ80G4P2Y1NMMi03gpw
 OULfqs2PDyjEMueMRUVF2pobdsaMz.Zl3MENte2lhVXsIiOOnU2qVJo5Ob8.SaQERNZAPBAlLOUI
 kjNUDVxIPtUncFO3DaeMgRwpWmKIxl7PRgbA1qdMP7Zob6TZGl4Ps_HqimZHikCiKbVgd7Oi5pBy
 YGCTFm3hkik.khxCMvfx1DzMt9BJL6Ga.IwlWCPiKvmY85lt9U5gVOd0tcr3tTTF56SHTwiDNbRy
 W3VjFFdHlOIQXpBG..52UkXxQi2fo1jszQT2czHaVttjBjzqg.xpe9BVwgwTMbAtdW.ttNPv8KlM
 X.UxlUtvsBvey46zb02FFHr8hNrGP1auU06pMyXuapElrBGkUh5g5ZWJgZ2Kg3E.aaadXDyhHbfb
 o9vW8ecJ73Thp1.9rfluwH2mLpNyJrnpwumtKgS6OW_xnLPGvSlRcdxb1eoQt29PDkNASPFDifBn
 10KhWL0d6pxLS6qOLvszj5wcaVrTAdhxaYIdCHjz061yS9FcySA9XhmSonfNsLZV3OAqLJ6WBN.L
 XunSQVH5cqMeMHBSty0UcTqObX6YOSXeW6k1oFl9noZWYi6lquhMqY5FferRj2u5yBuyhqezkegA
 Uuc3uK794C3CtrZrs4AaYaYActxOt2pnZC.9DNJ.seQ6TE5aEq5Q.2XJPhps8ygmEIdvFDi9i0d7
 hHPEzl4Vo.3ljYTiPFeTsE4BV4lFjC8YAknaOK7jsXYVeu6sMIFwn_Pija2Dhu86ayzY3E.5U5mj
 5FAEOnuZDuvD9CF9D9d40.EztJCADxWx2AQXgMse08Z..uMl_BoUbg4V5AbZDMarVFOCcfk7wVHB
 R0dciL729T3j3P9JD6RygdkMfON7jDgQq00O8Oruu8S7e6s2WN1BMttQuHbQeqINPS7trHRj4kj_
 n5JrQwcNDv7xqghtajX18DBDKZDrREP3FdNbchO8mnW1nXPe6itHvlJl1sebDUf9GWyE44aEWYOu
 nt.9f5Q6MXY2Yhd_dbVisUtNmcciyEeBbk1Zo.TOo2dT2Ta..tb0J_Oty.G_j9biFq.UBOANV61O
 .PPoAT9VoCrur3lPO_463Z6I74t5IilMffDlCcoo2I4oQcq3.uvck4EerYwWlQbKIR3wfXTTyTvA
 PYLr5ePe5PyShwgUYLgTpAxyrERTEuNfNuiVm8XhoTPVEG.eoZf4kvT7tA_SAME6lzs.d35xnkdl
 m9NfXRyHSLJG.PQ--
X-Sonic-MF: <casey@schaufler-ca.com>
X-Sonic-ID: 6e3fbf7f-9485-4180-a3ed-94c523ce8def
Received: from sonic.gate.mail.ne1.yahoo.com by sonic308.consmr.mail.ne1.yahoo.com with HTTP; Tue, 11 Mar 2025 18:10:44 +0000
Received: by hermes--production-gq1-7d5f4447dd-7qhsj (Yahoo Inc. Hermes SMTP Server) with ESMTPA ID 7843a08d9afb0fbf5c04f8cc0112d232;
          Tue, 11 Mar 2025 18:10:41 +0000 (UTC)
Message-ID: <b3b4585b-c9f3-4c87-9a9b-bc4137ecea47@schaufler-ca.com>
Date: Tue, 11 Mar 2025 11:10:41 -0700
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 0/2] smack: fix two bugs in setting task label
To: Konstantin Andreev <andreev@swemel.ru>
Cc: linux-security-module@vger.kernel.org,
 Casey Schaufler <casey@schaufler-ca.com>
References: <20250306224317.416365-1-andreev@swemel.ru>
Content-Language: en-US
From: Casey Schaufler <casey@schaufler-ca.com>
In-Reply-To: <20250306224317.416365-1-andreev@swemel.ru>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Mailer: WebService/1.1.23435 mail.backend.jedi.jws.acl:role.jedi.acl.token.atz.jws.hermes.yahoo

On 3/6/2025 2:43 PM, Konstantin Andreev wrote:
> These two patches have distinct subjects,
> but work on the same object,
>   security/smack/smack_lsm.c`do_setattr()
> and the second patch partially overwrites first,
> so I combine them in a series.
>
> Konstantin Andreev (2):
>   smack: fix bug: unprivileged task can create labels
>   smack: fix bug: setting task label silently ignores input garbage

There is a problem with this change. Some applications include a
trailing '\0' when writing to /proc/self/attr/smack/current, which
fails with this change. It may not be "correct", but it is expected.


>
>  security/smack/smack.h        |   3 +
>  security/smack/smack_access.c |  93 +++++++++++++++++++++++-------
>  security/smack/smack_lsm.c    | 104 ++++++++++++++++++++++------------
>  3 files changed, 143 insertions(+), 57 deletions(-)
>
