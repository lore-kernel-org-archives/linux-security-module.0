From: casey@schaufler-ca.com (Casey Schaufler)
Date: Tue, 26 Sep 2017 17:18:50 -0700
Subject: Security updates for v4.15 and beyond
In-Reply-To: <alpine.LRH.2.21.1709270954470.12698@namei.org>
References: <alpine.LRH.2.21.1709241454480.3941@namei.org>
	<5b63c120-5116-1e77-d090-331d2ae3aa8e@schaufler-ca.com>
	<alpine.LRH.2.21.1709251450150.30951@namei.org>
	<CAHC9VhQR=-0OLsRkP5Knk8_HLqBfEKjBvdnu6E4idSikJOt7dw@mail.gmail.com>
	<f989a3a4-507b-b28b-4eb4-8fd7ece96448@canonical.com>
	<alpine.LRH.2.21.1709270954470.12698@namei.org>
Message-ID: <5178fd26-dc6e-272c-9e4b-d8c0ca9d81c4@schaufler-ca.com>
To: linux-security-module@vger.kernel.org
List-Id: linux-security-module.vger.kernel.org

On 9/26/2017 5:03 PM, James Morris wrote:
> On Tue, 26 Sep 2017, John Johansen wrote:
>
>> I have to agree with Paul here, unless there are infrastructure
>> changes this feels like an extra hop. With next directly pulling
>> security (for infrastructure) and LSM changes merge conflicts will
>> show up there. At which point we are going to need to coordinate,
>> but these should be rare.
> Ok, it seems a consensus is emerging to go with Paul's idea of having 
> larger, frequently updated LSMs merge directly to Linus.  If Linus is okay 
> with that (I'm assuing he will be), then that's how we'll do thing from 
> now.
>
> Of course, any LSM or other security mechanism is still welcome to be 
> merged via my tree.

Smack will stick with the security tree for the time being.
The amount of change is small (due to simplicity! :) ) and I
seriously doubt Linus wants to deal with the onesy-twosy patch
volume.

I will stick with the security tree for the stacking work as well.
Having SELinux and AppArmor going off on their own is a royal pain
for that, but there's already audit and networking to worry about
so it's hard to argue that life is going to be that much harder.

Oh well. I knew the job was dangerous when I took it.

--
To unsubscribe from this list: send the line "unsubscribe linux-security-module" in
the body of a message to majordomo at vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
