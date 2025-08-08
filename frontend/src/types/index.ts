export interface User {
  id: number;
  email: string;
  username: string;
  firstName?: string;
  lastName?: string;
  phone?: string;
  avatar?: string;
  isActive: boolean;
  isVerified: boolean;
  role: string;
  createdAt: string;
  updatedAt: string;
}

export interface Category {
  id: number;
  name: string;
  slug: string;
  description?: string;
  icon?: string;
  parentId?: number;
  isActive: boolean;
  createdAt: string;
  updatedAt: string;
  parent?: Category;
  children?: Category[];
}

export interface Listing {
  id: number;
  title: string;
  description: string;
  price: number;
  currency: string;
  location: string;
  userId: number;
  categoryId: number;
  status: 'active' | 'sold' | 'inactive';
  viewCount: number;
  isPromoted: boolean;
  createdAt: string;
  updatedAt: string;
  user?: User;
  category?: Category;
  images?: ListingImage[];
}

export interface ListingImage {
  id: number;
  listingId: number;
  url: string;
  alt?: string;
  order: number;
  createdAt: string;
  updatedAt: string;
}

export interface Favorite {
  id: number;
  userId: number;
  listingId: number;
  createdAt: string;
  user?: User;
  listing?: Listing;
}

export interface Message {
  id: number;
  senderId: number;
  receiverId: number;
  listingId?: number;
  content: string;
  isRead: boolean;
  createdAt: string;
  updatedAt: string;
  sender?: User;
  receiver?: User;
  listing?: Listing;
}

export interface ApiResponse<T> {
  data: T;
  message?: string;
  success: boolean;
}

export interface PaginatedResponse<T> {
  data: T[];
  pagination: {
    currentPage: number;
    totalPages: number;
    totalItems: number;
    itemsPerPage: number;
  };
}

export interface LoginRequest {
  email: string;
  password: string;
}

export interface RegisterRequest {
  email: string;
  username: string;
  password: string;
  firstName?: string;
  lastName?: string;
  phone?: string;
}

export interface AuthResponse {
  user: User;
  token: string;
}

export interface CreateListingRequest {
  title: string;
  description: string;
  price: number;
  currency?: string;
  location: string;
  categoryId: number;
}

export interface UpdateListingRequest extends Partial<CreateListingRequest> {
  status?: 'active' | 'sold' | 'inactive';
}
