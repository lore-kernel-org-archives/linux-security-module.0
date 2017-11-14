From: mjg59@google.com (Matthew Garrett)
Date: Tue, 14 Nov 2017 11:42:29 -0800
Subject: [PATCH V3 1/2] security: Add a cred_getsecid hook
In-Reply-To: <1509383027.10174.5.camel@tycho.nsa.gov>
References: <20171026084055.25482-1-mjg59@google.com>
	<1509027658.25604.4.camel@tycho.nsa.gov>
	<CACdnJuu8fvVoD+G50dWtauUUa3H1tUAbBgzusc_CKNBugrVmwQ@mail.gmail.com>
	<1509383027.10174.5.camel@tycho.nsa.gov>
Message-ID: <CACdnJuvymPL4hiz2ZhdAxknVhGdnS9_XCkrk7mR_CDWXwgW5gg@mail.gmail.com>
To: linux-security-module@vger.kernel.org
List-Id: linux-security-module.vger.kernel.org

On Mon, Oct 30, 2017 at 10:03 AM, Stephen Smalley <sds@tycho.nsa.gov> wrote:
> On Mon, 2017-10-30 at 10:57 +0000, Matthew Garrett via Selinux wrote:
>> On Thu, Oct 26, 2017 at 3:20 PM, Stephen Smalley <sds@tycho.nsa.gov>
>> wrote:
>> > On Thu, 2017-10-26 at 01:40 -0700, Matthew Garrett via Selinux
>> > wrote:
>> > > +static void selinux_cred_getsecid(const struct cred *c, u32
>> > > *secid)
>> > > +{
>> > > +     rcu_read_lock();
>> > > +     *secid = cred_sid(c);
>> > > +     rcu_read_unlock();
>> >
>> > Is rcu_read_lock() necessary here? Seems like we use cred_sid() in
>> > many
>> > places without it.
>>
>> Ah, I thought it was based on task_sid(), but I guess that's actually
>> protecting the __task_cred()?
>
> It appears to me that in all other cases, we are either dealing with
> the current cred, or something in the call chain of cred_sid() is
> holding a reference to the cred, or something in the call chain of
> cred_sid() has called rcu_read_lock() already.  I might have missed
> something though, and I don't know how safe it is to assume that all
> future callers will do this.  cc'd David for his thoughts.

Hi David,

Any opinion on this?

Thanks!
--
To unsubscribe from this list: send the line "unsubscribe linux-security-module" in
the body of a message to majordomo at vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
