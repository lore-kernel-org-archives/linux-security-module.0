From: zohar@linux.vnet.ibm.com (Mimi Zohar)
Date: Tue, 20 Mar 2018 12:11:09 -0400
Subject: Problem mounting pseudo filesystems with SMACK and IMA enabled.
In-Reply-To: <CABatt_yk+pgwxHVv+RY08xFDOfzxb4w6ELW7RxhW6gWQ=5Hvnw@mail.gmail.com>
References: <CABatt_zunDV_g3oR5_O5GMm0EVEnT0LEnmjp5PQgu26Q6T+4SA@mail.gmail.com>
	<1521206743.3503.29.camel@linux.vnet.ibm.com>
	<CABatt_zxC1W-OirRLM-PVERAkUZaJDSnRDc_i4a7ebh-NJZ9Ag@mail.gmail.com>
	<1521211762.3503.46.camel@linux.vnet.ibm.com>
	<77f5ac13-dd79-abf7-13b2-336bf799a25c@schaufler-ca.com>
	<CABatt_yk_73BsgaD7UsHOL9wse0FxR=i1YXneUfx6aUiBra_JQ@mail.gmail.com>
	<CABatt_zM0Uu2fEwyORKTLYMC2_KeqSkcye1toBxhyjkgOUr62Q@mail.gmail.com>
	<1521474460.3503.191.camel@linux.vnet.ibm.com>
	<CABatt_wfwRqJRie=eoaaXnfxd7EUBhDL-jPjPbBHbwcnpMWj7g@mail.gmail.com>
	<1521552744.22230.25.camel@linux.vnet.ibm.com>
	<CABatt_yk+pgwxHVv+RY08xFDOfzxb4w6ELW7RxhW6gWQ=5Hvnw@mail.gmail.com>
Message-ID: <1521562269.22230.40.camel@linux.vnet.ibm.com>
To: linux-security-module@vger.kernel.org
List-Id: linux-security-module.vger.kernel.org

On Tue, 2018-03-20 at 15:01 +0000, Martin Townsend wrote:
> 
> Not sure why SMACK is not already there, do you want me to submit this
> patch formally or is there a good reason for the omission?

At some point, we should introduce a flag indicating a pseudo
fileesystem, but for now including SMACK in the list of pseudo
filesystems not measured sounds right.?

thanks,

Mimi

--
To unsubscribe from this list: send the line "unsubscribe linux-security-module" in
the body of a message to majordomo at vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
