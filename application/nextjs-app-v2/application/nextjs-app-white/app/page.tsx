import Image from 'next/image'

export default function Home() {
  return (
    <main className="flex justify-center items-center h-screen">
      <div>
        <Image
          className="text-stone-900"
          src="/next.svg"
          alt="Next.js Logo"
          width={180}
          height={37}
          priority
        />
      </div>
    </main>
  )
}
