From: james.l.morris@oracle.com (James Morris)
Date: Thu, 7 Dec 2017 11:00:31 +1100 (AEDT)
Subject: [RFC 0/3] Safe, dynamically (un)loadable LSMs
In-Reply-To: <CAMp4zn_RCt3qVFwt_67xS1Nq-4VFpiUQqZ20GNzSo8xfy5Ledw@mail.gmail.com>
References: <20171126221545.GA13751@ircssh-2.c.rugged-nimbus-611.internal>
	<8c8dd781-d30a-7105-011d-127cf5188426@schaufler-ca.com>
	<CAMp4zn_=4r9_eH1pUOfzxmRuQL+nVk9megx325s=f1Myv_opZg@mail.gmail.com>
	<866f86cf-d28a-3da7-4a2d-cbc5a330bd4a@schaufler-ca.com>
	<CAMp4zn_RCt3qVFwt_67xS1Nq-4VFpiUQqZ20GNzSo8xfy5Ledw@mail.gmail.com>
Message-ID: <alpine.LFD.2.20.1712071053420.8348@localhost>
To: linux-security-module@vger.kernel.org
List-Id: linux-security-module.vger.kernel.org

On Wed, 6 Dec 2017, Sargun Dhillon wrote:

> Should I respin this patch sans module unloading? Still a set of dynamic 
> hooks that are independent to allow for sealable memory support.

Yes, please.

> I'm also wondering what people think of the fs change? I don't think 
> that it makes a lot of sense just having one giant list. I was thinking 
> it might make more sense using the module_name instead.

I don't know how useful this will be in practice.  Who/what will be 
looking at these entries and why?


-- 
James Morris
<james.l.morris@oracle.com>

--
To unsubscribe from this list: send the line "unsubscribe linux-security-module" in
the body of a message to majordomo at vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
