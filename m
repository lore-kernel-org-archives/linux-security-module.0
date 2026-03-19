Received: from sonic305-27.consmr.mail.ne1.yahoo.com (sonic305-27.consmr.mail.ne1.yahoo.com [66.163.185.153])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2AF763ECBE4
	for <linux-security-module@vger.kernel.org>; Thu, 19 Mar 2026 17:51:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=66.163.185.153
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773942702; cv=none; b=IFYWRvvuU+3EsMQcTZJyyhaI7GT4dFr+kxZWIZMwVCFywzVojzZgD9K4HeFAKL43q85nL7DopN/7SJOfsPTFsiqHFxKRtwD+k8kKImAn62HK3YiGrYPOqykhjsKrgwVMyH0ANpdL41QaQ28A39gixqWjHjFzI/i4ERjduBECIvY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773942702; c=relaxed/simple;
	bh=D/WQWA9b4kQLeOZ+xSiiNmjeHVJZJFpXX+t7fx44akg=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=rSfg4nW088B1ED0AOizCfmRHGXVZ0kiABSURmpObwchmUrX2MCCLQphvZvIDBHi/lHXUevPKnVpJWkMKclHzgOs4ZfWalLtfCMM7+xko8MUadb9s0igwJDOQQv4Op9ckFKNjlgLplHLwcvwxsHGYx1Z3PCQgxmujE9Ip+brW6YQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=schaufler-ca.com; spf=none smtp.mailfrom=schaufler-ca.com; dkim=pass (2048-bit key) header.d=yahoo.com header.i=@yahoo.com header.b=OsudCZz+; arc=none smtp.client-ip=66.163.185.153
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=schaufler-ca.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=schaufler-ca.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=yahoo.com header.i=@yahoo.com header.b="OsudCZz+"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1773942691; bh=Pg+4BxK0NPvB6iZRMKoVBOpAWheHY8kyA5B8ghw+xpA=; h=Date:Subject:To:Cc:References:From:In-Reply-To:From:Subject:Reply-To; b=OsudCZz+DhGYlwi15mlhNtUG25bCOeJFp2UWPPt7W2zr4DKtxC+S4qvG25bV0/HwilFEyqLHDgJQ9OjNS82rddngAXjbXuRnhWEM958OibQ37apdxZsNL/8FxLrd0ySojdQGkFYp3kOVxERqacNNcCrmeHVJlpMvw/nvlIW3sN6Nq4y0zRX/i8DsfkEMPJSS2xsp2EnFBpe5OZlrpN+hgtdaFrbsOBNG8g8aYuK+1rR98B4vY7cNzv4d8GMxpXt/bpfVzubUQOHeWiUNPz7a8lmWuKwqDc2CM8bbzsiu7hfynGsOhitBhsJtvnuycLnfSLGu25+vSTQI9uOPQ4rIKg==
X-SONIC-DKIM-SIGN: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1773942691; bh=1oCWO/9WYaLQp7kLnmwjX+nuMdS5Dln87I7Khvixnl0=; h=X-Sonic-MF:Date:Subject:To:From:From:Subject; b=ktVe0pkHpwY0d8lSPD3CwTEahWQcNxjJOBNbiATflGVcouVLQWzpwvijZttookmrtDAKU5E9jnz56l+AzgRvZB/YX34ATlXLS3Io9zHCUzVaCPZ2LItRGucETQYmboOZyj86wwEVSDogo90Us+lf0HwHJS+J8h0kp4Io/T/s5+PQpLGS+BSkDptEBIIorLltRsuZNV260QRuMn4uLFB2bnfsZu3dHB85wAZzM6aNBgeKJsTq6CBtGE+D3EIab1zps5bfsxrWWebVe6Hpoq9aXq+XwJqV7FZ+cGod1vv00vtF6vaANrpazqO7kbeZUJ1z6y/E18qPrbhmEW6X4QSyfg==
X-YMail-OSG: 8LxPzE8VM1lTN63PTuPxOLrLoXq0GR9aKOzPMcogyeCW53LpXWzFgTdHWgprUNa
 VBZ8k9uohtOdIo3xZBDN1ucPyID_r6hVgI16Ab3Qvt9BqYpnFxwHwqVaN7jB4e4kVoDA5lF2oN.M
 FrOo5iDEEYVi1XdGty6EQEiEcZaU.sC9Mdqcbs117RDVfW4hepEj4N6o8npowDvVqji_XD5bf6vd
 L_Ok8FZcG3wiaJmeSKp.JmynTOJbzcj4RIQiEPsETxJKACiWut6PcvMFQ4NjMVcj42sjIrHHoqXa
 BuPpyJy8K6SqKbhgR0HCN_wX1D5bCWVaPFdiq3sD9UP6_ZnNfY2VNNGYp5GFAEv7fPVRve6QkOPS
 c4aJJZBArOKG1rDbQVh1HbZwS37l6BDxzNihzx_0gl0ZsGWCJQdA1Fz7YHzBnivCt3ImmW5jdlXI
 _NNAPLVKg9Led8d4cGo4FhOU0EW0SbLhzz1IMhaLrx8FKrTIAuhoLy1cxookqqLMFmxG5524W.o6
 WwfxEFAu_y72YHNl.tU8Yf4w6OVUInNhw9tS4KIp17j9MIqPfPMfLl_VLXRl7gKeOAHp1Zso6nh.
 p3_ew49bl3O2ImLtbPDInJ1wYFDQm6pFrkH48RQ0TKCgVjblkylQqKctk94pL0rzaYl6aKTnI5GE
 tyi_Io.qRJ6AWEJw3yhLysvouJBevfFotXcppj.8ZdBSDNvn7UQdcXSeUyWNKpcRsBhi.VqSnew9
 UjTnME4HWYFqndzdgj0aiqN6otc0eA8hCG8H6e5h40Tvs140bzANG1BATOpamDlszQunXTan8BRa
 O.9NXb7_4oMEsgko6rPAz7i4oneb_Jxso1Rx0Qz8ZlZgvJsSiiC5hH1dOl0O4hce3sVSJGZsvd_l
 HtltWMuFGj6HvQfiVN0.P0H1gCApdK43mxOt0Kt1Gbxdq7rqp0Trg3Qyn75Y88PVQvdPSQ5WMXim
 vYCKGysNOLdRN6K9ceLCbzYST3MYLy1KSQlCKVq4l.G8JjF.LqclR5TPG4lZqFdnehFU0rljbaGW
 0wIzjTfn7Kc.TyQtWP9D3Mx6E15e73lIfnUofBbc6yqhra2wJUOpNBbBcQPIOeNmb.E0hdaveCNg
 GNZ69azdrw.6BBrVXXekrEQsPHEkTvDJfrlgw9whXToGZXeg_uAHKoVlx9ah15aPSfZTwHd31Y9p
 9NCjp3mgST71ZdPDnQeD42Hinhv2IJshewCzbI.ETTGMUsdKtUAlM060kb3qGtvRpS29orufpGSe
 UPkl4uIb4IH8ukoA8QAJyZ4hwvdsyHU0lEImXRe9Ew2TtOrRr3_uRYjvu5lgJW3BA0e7U.P_eQ0e
 US6ApxTQ1uw85J96um0WmLMnw9BL.rqm2P2gCbZCvp3B2d0PSPbXqrGSozJAP9GmvFxixny_nxK2
 QaCjFVLVmimeTwKTJBPawx1ysFAMza0neEaXX5kDlEFeDoaYBAvMiIbRgHbNnGU6fzODn142m1sk
 aWvRa2S0tkYsPeU5zlo.X5VY9UDhjWFq90afMZ4ePJKTuWFUJGcr0Rqfkz3HNREUKN3LjLw3UI1M
 2CWfAavSzi34UkznfbXvx6yYdnTJPU7qI_LNGtrimM4FtxE3Kk7pBG9sZ64RwJIQYuYM1ucd8TUK
 efFTLZo_mUzHBAoXPJmybfNq.J._zbUfCB7hGrbDV.YympIZSemHFKdmTnyiboRIjGSjulsm.Sgb
 5K_bFgGVz223vJhw_7BKonsLUBA0itC8ihsYb_iU7NddYXfhlAoicRzT5V23d6zdinCMhOPujzC8
 lmBhSMqI1djirxlk25FYaAcJnaswGdLu2l2x1YTMnHg1uckffPs0dAkfNPSwXQGU_w5msoX0OHEB
 yrICQcneyA2O4lIbi2k_fyPFZLXkVe_A1LIui7TCRkqA8Fb4aYRzV35wFBSR7FU6tmMKTdVReVxx
 Ucz1lk5FrZ0f.E3sIdsevNqqtqihXt8F7p8a7opGEQEMgU0PKLEPS0OUASse9eeHHe2eqO.sbLb7
 8PoA5jy4uRv8i2XY0ISnCmsJYMUcMzt2Xlwfn01Y1bUWXzGCqRjmViRKoFAJWSEj.KlKtqOP40nS
 YX1TB9iaw2_U782kQlAum71LQGrWsrAOR.ngh9zWO2GgRDZoo9hZMaFc8Y0zsypxZumhNkEK_E3N
 ZYkqhrlptdTVcWywEEaoOLIW.zcSyM0VSk.wovBLZS5fEfQY81DhiF.rkJhIYUMKn_NKkYy1mXRf
 kuEm7.FNgvghhmB1j0xK.3dbKl.n55NUXFAaerqZf1TXjLr5gopPEifma3TIsbYQGubqyhaVhUHP
 F6fwH09iEdw--
X-Sonic-MF: <casey@schaufler-ca.com>
X-Sonic-ID: d52259aa-43b0-474d-a6fb-5fe0b5882db1
Received: from sonic.gate.mail.ne1.yahoo.com by sonic305.consmr.mail.ne1.yahoo.com with HTTP; Thu, 19 Mar 2026 17:51:31 +0000
Received: by hermes--production-gq1-6dfcf9f8b-vlhlt (Yahoo Inc. Hermes SMTP Server) with ESMTPA ID 4ebe706e084b84abc057ad803d959c8c;
          Thu, 19 Mar 2026 17:51:26 +0000 (UTC)
Message-ID: <80ff003b-51fd-4ec8-9505-dfc1c5890ced@schaufler-ca.com>
Date: Thu, 19 Mar 2026 10:51:24 -0700
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] lsm: Fix the crash issue in xfrm_decode_session
To: Feng Yang <yangfeng59949@163.com>
Cc: jmorris@namei.org, linux-kernel@vger.kernel.org,
 linux-security-module@vger.kernel.org, paul@paul-moore.com,
 serge@hallyn.com, Casey Schaufler <casey@schaufler-ca.com>
References: <df35542e-d58f-47db-8a4f-92698281a69a@schaufler-ca.com>
 <20260319022208.69924-1-yangfeng59949@163.com>
Content-Language: en-US
From: Casey Schaufler <casey@schaufler-ca.com>
In-Reply-To: <20260319022208.69924-1-yangfeng59949@163.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Mailer: WebService/1.1.25380 mail.backend.jedi.jws.acl:role.jedi.acl.token.atz.jws.hermes.yahoo

On 3/18/2026 7:22 PM, Feng Yang wrote:
> On Wed, 18 Mar 2026 10:09:47 -0700, Casey Schaufler wrote:
>> On 3/17/2026 11:19 PM, Feng Yang wrote:
>>> From: Feng Yang <yangfeng@kylinos.cn>
>>>
>>> After hooking the following BPF program:
>>> SEC("lsm/xfrm_decode_session")
>>> int BPF_PROG(lsm_hook_xfrm_decode_session, struct sk_buff *skb, u32 *secid, int ckall)
>>> {
>>>     return 1; // Any non-zero value
>>> }
>>> Subsequent packet transmission triggers will cause a kernel panic:
>> LSM hooks that use or provide secids cannot be stacked. That is,
>> you can't provide a BPF LSM hook and an SELinux LSM hook and expect
>> correct behavior. Your proposed "fix" removes a legitimate check.
> I'm very sorry, I didn't quite understand what you meant.
>
> Maybe my commit message wasn't clear. I only used a BPF LSM hook without SELinux stacking enabled.

Do i understand correctly that you do not have SELinux enabled?

> Therefore, is it the expected behavior that simply using
> SEC("lsm/xfrm_decode_session")
> int BPF_PROG(lsm_hook_xfrm_decode_session, struct sk_buff *skb, u32 *secid, int ckall) {
>     return -1;
> }
> would cause a kernel panic?

Yes. As the infrastructure is written, any return other than 0 is erroneous.
You will need to query the SELinux developers about why they decided to
implement the xfrm handling in this way.

>  If not, and if the BUG_ON check is still necessary,
> then does it mean we need to modify the return value validation logic in the BPF
> verifier to ensure that only BPF programs returning 0 are accepted for this hook?
>
> Thanks.
>
>
